//
//  UtilApi.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/28.
//

import Foundation
import Alamofire


struct UtilApi {
    
    static func getDetailList(parameter: Parameters, completionHandler: @escaping(Result<UtilModelList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/Board/info")!
        AF.request(urlString, method: .get, parameters: parameter, encoding: URLEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(response):
                    debugPrint(response)
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObject as? [String: Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let utilList = try decoder.decode(UtilModelList.self, from: response)
                                let result = Result<UtilModelList>.success(data: utilList)
                                completionHandler(result)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func getPushList(userId: Int, completionHandler: @escaping(Result<PushModelList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/Message/Push/\(userId)/List")!
        AF.request(urlString, method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                debugPrint(response)
                switch response.result {
                case let .success(response):
                    do {
                        let decoder = JSONDecoder()
                        let pushList = try decoder.decode(PushModelList.self, from: response)
                        if pushList.code == 200 {
                            let result =  Result<PushModelList>.success(data: pushList)
                            completionHandler(result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        
    }
    
    static func getAdminLogin(parameter: Parameters, completionHandler: @escaping(AdminModelList) -> ()) {
        guard let urlString:URL = URL(string: "http://3.36.188.237:8080/auth/signin/admin") else { return }
        AF.request(urlString, method: .get, parameters: parameter, encoding: URLEncoding.default)
            .validate(statusCode: 200...500)
            .responseData { response in
                switch response.result {
                case let .success(response):
                    do {
                        let decoder = try JSONDecoder().decode(AdminModelList.self, from: response)
                        completionHandler(decoder)
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func getAdminBlockList(completionHandler: @escaping(AdminBlockList) -> ()) {
        guard let urlString:URL = URL(string: "http://3.36.188.237:8080/Message/sueList") else { return }
        AF.request(urlString, method: .get, encoding: URLEncoding.default)
            .validate(statusCode: 200...500)
            .responseData { response in
                switch response.result {
                case let .success(response):
                    do {
                        let decoder = try JSONDecoder().decode(AdminBlockList.self, from: response)
                        completionHandler(decoder)
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func postAdminBlock(parameter:Parameters, completionHandler:@escaping(AdminSueModelList) -> ()) {
        guard let urlString:URL = URL(string: "http://3.36.188.237:8080/Message/judgeSue") else { return }
        AF.request(urlString, method: .post, parameters: parameter, encoding: JSONEncoding.default)
            .validate(statusCode: 200...500)
            .responseData { response in
                switch response.result {
                case let .success(response):
                    do {
                        let decoder = try JSONDecoder().decode(AdminSueModelList.self, from: response)
                        completionHandler(decoder)
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
    
}


extension UtilApi {
    enum Result<T> {
        case success(data : T?)
        case failure(error : Error)
    }
}
