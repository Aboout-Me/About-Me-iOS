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
    
    static func postLikeButton(questId: Int, authorId: Int, completion: @escaping () -> Void) {
        let urlComponent = URLComponents(string: "\(API_URL)/Board/likes/")
        let parameters: [String: Any] = [
            "questId": questId,
            "authorId": authorId,
            "userId": userId
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
    
    static func postScrapButton(questId: Int, authorId: Int, completion: @escaping () -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/Board/scrap/")
        let parameters: [String: Any] = [
            "questId": questId,
//            "authorId": authorId,
            "userId": userId
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
    
    static func getSocialSearch(keyword: String, completion: @escaping (SocialSearchResponse) -> Void) {
        let urlComponent = URLComponents(string: "\(API_URL)/Board/\(userId)/search?keyword=\(keyword)")
        guard let url = urlComponent?.url else { return }
        print(url)
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                let stringResponse = String(data: response.data!, encoding: .utf8)
                print(stringResponse)
                
                do {
                    let data = try JSONDecoder().decode(SocialSearchResponse.self, from: response.data!)
                    completion(data)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func postReport(suedUserId: Int, targetQuestionId: Int, sueReason: String, sueType: String, completion: @escaping (SocialReportResponse) -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/Message/sue")
        let parameters: [String: Any] = [
            "suedUserId": suedUserId,
            "targetQuestionId": targetQuestionId,
            "sueReason": sueReason,
            "sueType": sueType
        ]
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                let stringResponse = String(data: response.data!, encoding: .utf8)
                print(stringResponse)
                
                do {
                    let data = try JSONDecoder().decode(SocialReportResponse.self, from: response.data!)
                    completion(data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func deleteComment(commentId: Int, completion: @escaping (SocialCommentDeleteResponse) -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/Board/comment?commentId=\(commentId)&userId=\(userId)")

        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                let stringResponse = String(data: response.data!, encoding: .utf8)
                print(stringResponse)
                
                do {
                    let data = try JSONDecoder().decode(SocialCommentDeleteResponse.self, from: response.data!)
                    completion(data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
