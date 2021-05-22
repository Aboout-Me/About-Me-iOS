//
//  AdvisoryApiService.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/29.
//

import Alamofire

//GET http://3.36.188.237:8080/Mypage/10Q10A/theme/{user}

let API_URL = "http://3.36.188.237:8080"
let userId = 1

struct AdvisoryApiService {
    static func getAdvisoryAnswerList(completion: @escaping (AdvisoryList?) -> Void) {
        let urlComponent = URLComponents(string: "\(API_URL)/MyPage/10Q10A/theme/\(userId)")
        guard let url = urlComponent?.url else { return }
        print(url)
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)

                do {
                    let data = try JSONDecoder().decode(AdvisoryList.self, from: Data(stringResponse!.data(using: .utf8)!))
                    completion(data)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func saveAdvisoryAnswerList(answerList: AdvisoryPostList, completion: @escaping () -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/MyPage/10Q10A/answer")
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .post, parameters: try! answerList.asDictionary(), encoding: JSONEncoding.default)
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

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
