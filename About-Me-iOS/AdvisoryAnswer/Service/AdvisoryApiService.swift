//
//  AdvisoryApiService.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/29.
//

import Alamofire

//GET http://3.36.188.237:8080/Mypage/10Q10A/theme/{user}

struct AdvisoryApiService {
    static func getAdvisoryAnswerList(completion: @escaping (AdvisoryList?) -> Void) {
        let urlComponent = URLComponents(string: "\(API_URL)/MyPage/10Q10A/theme/\(USER_ID)")
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
    
    static func getAdvisoryDetailList(stage: Int, theme: String, completion: @escaping (AdvisoryDetailList) -> Void) {
        let urlString = "\(API_URL)/MyPage/10Q10A/listDetail/\(USER_ID)/\(stage)/\(theme)"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: encodedString) else { return }
        print(url)
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)

                do {
                    let data = try JSONDecoder().decode(AdvisoryDetailList.self, from: Data(stringResponse!.data(using: .utf8)!))
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
    
    static func saveAndUpdateAdvisoryAnswerList(answerList: AdvisoryPostList, completion: @escaping (AdvisoryResponse) -> Void) {
        let urlComponent = URLComponents(string: "\(API_URL)/MyPage/10Q10A/answer2")
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .post, parameters: try! answerList.asDictionary(), encoding: JSONEncoding.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)

                do {
                    let data = try JSONDecoder().decode(AdvisoryResponse.self, from: Data(stringResponse!.data(using: .utf8)!))
                    completion(data)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func editAdvisoryAnswerList(answerList: AdvisoryPostList, completion: @escaping () -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/MyPage/10Q10A/updateAnswer")
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .put, parameters: try! answerList.asDictionary(), encoding: JSONEncoding.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func updateOneAdvisoryAnswer(answerList: AdvisoryUpdateList, completion: @escaping () -> Void) {
        let urlComponent = URLComponents(string:  "\(API_URL)/MyPage/10Q10A/updateAnswer")
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .put, parameters: try! answerList.asDictionary(), encoding: JSONEncoding.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)
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
