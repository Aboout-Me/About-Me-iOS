//
//  SocialApiService.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/25.
//

import Alamofire

struct SocialApiService {
    static func getSocialList(state: String, color: String?, completion: @escaping ([SocialPostList]?) -> Void) {
        var urlString = "\(API_URL)/Board/\(state)/\(userId)"
        if let color = color, color != "" {
            urlString.append("?color=\(color)")
        }
        
        let urlComponent = URLComponents(string: urlString)
        guard let url = urlComponent?.url else { return }
        print(url)
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                let stringResponse = String(data: response.data!, encoding: .utf8)
                print(stringResponse)

                do {
                    let data = try JSONDecoder().decode(SocialListResponse.self, from: Data(stringResponse!.data(using: .utf8)!))
                    completion(data.postList)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSocialDetail(answerId: Int, authorId: Int, completion: @escaping (SocialDetailResponse?) -> Void) {
        var urlString = "\(API_URL)/Board/info?answer_id=\(answerId)&user_id=\(userId)"
        
        let urlComponent = URLComponents(string: urlString)
        guard let url = urlComponent?.url else { return }
        print(url)
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                let stringResponse = String(data: response.data!, encoding: .utf8)
                print(stringResponse)

                do {
                    let data = try JSONDecoder().decode(SocialDetailResponse.self, from: response.data!)
                    completion(data)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func saveSocialComment(answerId: Int, comment: String, completion: @escaping () -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/Board/comment")
        let parameters: [String: Any] = [
            "answerId": answerId,
            "authorId": userId,
            "comment": comment
        ]
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)

//                let data = try! JSONDecoder().decode(AdvisoryList.self, from: Data(stringResponse!.data(using: .utf8)!))
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}