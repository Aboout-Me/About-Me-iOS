//
//  ProfileServerApi.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/17.
//

import Alamofire


struct ProfileServerApi {
    static func getCategoryProgress(userId: Int, completionHandler: @escaping(Result<[CategoryProgressModel]>) -> ()){
        let urlString: URL = URL(string: "http://3.36.188.237:8080/MyPage/Progressing/\(userId)")!
        AF.request(urlString, method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                debugPrint(response)
                switch response.result {
                case let .success(response):
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObject as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let categoryList = try decoder.decode(CategoryProgressList.self, from: response)
                                let result = Result<[CategoryProgressModel]>.success(data: categoryList.data)
                                completionHandler(result)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    if error.isInvalidURLError {
                        let urlError = Result<[CategoryProgressModel]>.failure(error: ProfileError.client.failureReason!)
                        completionHandler(urlError)
                    } else {
                        let serverError = Result<[CategoryProgressModel]>.failure(error: ProfileError.server.failureReason!)
                        completionHandler(serverError)
                    }
                }
            }
    }
    
    static func getWeeklyProgress(userId: Int, completionHandler: @escaping(Result<WeeklyProgressList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/MyPage/WeeklyProgressing/\(userId)")!
        AF.request(urlString, method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseData { (response) in
                debugPrint(response)
                switch response.result {
                
                case let .success(response):
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObject as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let weeklyList = try decoder.decode(WeeklyProgressList.self, from: response)
                                let result = Result<WeeklyProgressList>.success(data: weeklyList)
                                completionHandler(result)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    if error.isInvalidURLError {
                        let clientError = Result<WeeklyProgressList>.failure(error: ProfileError.client.failureReason!)
                        completionHandler(clientError)
                    } else {
                        let serverError = Result<WeeklyProgressList>.failure(error: ProfileError.server.failureReason!)
                        completionHandler(serverError)
                    }
                }
                
            }
    }
}



extension ProfileServerApi {
    enum Result<T> {
        case success(data: T?)
        case failure(error: String)
    }
}

enum ProfileError: Error {
    case server
    case client
}

extension ProfileError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .client:
            return "서버 통신을 실패하였습니다. 디버깅 부탁 드립니다."
        case .server:
            return "서버 통신이 불가능 합니다. 서버에게 문의 부탁드립니다."
        }
    }
}
