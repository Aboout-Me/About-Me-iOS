//
//  HomeServerApi.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/08.
//

import Alamofire
import UIKit


struct HomeServerApi {
    static func getHomeCardList(userId:Int, completionHandler: @escaping(Result<HomeCardList>) -> ()) {
        let urlstring:URL = URL(string: "http://3.36.188.237:8080/Board/dailyColors/\(userId)")!
        AF.request(urlstring, method: .get, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(response):
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObject as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let homeList = try decoder.decode(HomeCardList.self, from: response)
                                let result = Result<HomeCardList>.success(data: homeList)
                                completionHandler(result)
                            }
                        }
                    } catch {
                        print("get Error", error.localizedDescription)
                    }
                case let .failure(error):
                    if error.isInvalidURLError {
                        let urlError = Result<HomeCardList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(urlError)
                    } else if error.isResponseValidationError {
                        let validationError = Result<HomeCardList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(validationError)
                    } else {
                        let serverError = Result<HomeCardList>.failure(error: HomeError.server.failureReason!)
                        completionHandler(serverError)
                    }
                }
            }
    }
    
    static func postHomecardListSave(parameter: HomeCardSaveParamter, completionHandler: @escaping(Result<HomeCardSaveList>) -> ()) {
        let urlString:URL = URL(string: "http://3.36.188.237:8080/Board/dailyColors")!
        AF.request(urlString, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default)
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
                                let homeSaveList = try decoder.decode(HomeCardSaveList.self, from: response)
                                let result = Result<HomeCardSaveList>.success(data: homeSaveList)
                                completionHandler(result)
                            }
                        }
                    } catch {
                        print("post Error", error.localizedDescription)
                    }
                case let .failure(error):
                    if error.isParameterEncoderError {
                        let parameterError = Result<HomeCardSaveList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(parameterError)
                    } else if error.isResponseValidationError {
                        let vaildationError = Result<HomeCardSaveList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(vaildationError)
                    } else if error.isInvalidURLError {
                        let urlError = Result<HomeCardSaveList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(urlError)
                    } else {
                        let serverError = Result<HomeCardSaveList>.failure(error: HomeError.server.failureReason!)
                        completionHandler(serverError)
                    }
                }
            }
    }
        
    static func deleteHomeCardList(seq: Int, completionHandler: @escaping(Result<HomeCardDeleteList>) -> ()) {
        let urlString:URL = URL(string: "http://3.36.188.237:8080/Board/dailyColors/\(seq)")!
        AF.request(urlString, method: .delete, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(response):
                    debugPrint(response)
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObject as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let homeDeleteList = try decoder.decode(HomeCardDeleteList.self, from: response)
                                let result = Result<HomeCardDeleteList>.success(data: homeDeleteList)
                                completionHandler(result)
                                print(result)
                            }
                        }
                    } catch {
                        print("delete Error", error.localizedDescription)
                    }
                case let .failure(error):
                    if error.isInvalidURLError {
                        let urlError = Result<HomeCardDeleteList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(urlError)
                    } else if error.isResponseValidationError {
                        let validationError = Result<HomeCardDeleteList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(validationError)
                    } else {
                        let serverError = Result<HomeCardDeleteList>.failure(error: HomeError.server.failureReason!)
                        completionHandler(serverError)
                    }
                }
            }
    }
    
    static func putHomeCardList(parameter: HomeCardEditParamter, completionHandler: @escaping(Result<HomeCardEditList>) -> ()) {
        let urlString:URL = URL(string: "http://3.36.188.237:8080/Board/dailyColors")!
        AF.request(urlString, method: .put, parameters: parameter, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(response):
                    debugPrint(response)
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObject as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let homeputList = try decoder.decode(HomeCardEditList.self, from: response)
                                let result = Result<HomeCardEditList>.success(data: homeputList)
                                completionHandler(result)
                            }
                        }
                    } catch {
                        print("put Error", error.localizedDescription)
                    }
                case let .failure(error):
                    if error.isParameterEncoderError {
                        let parameterError = Result<HomeCardEditList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(parameterError)
                    } else if error.isInvalidURLError {
                        let urlError = Result<HomeCardEditList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(urlError)
                    } else if error.isResponseValidationError {
                        let validationError = Result<HomeCardEditList>.failure(error: HomeError.client.failureReason!)
                        completionHandler(validationError)
                    } else {
                        let serverError = Result<HomeCardEditList>.failure(error: HomeError.server.failureReason!)
                        completionHandler(serverError)
                    }
                }
            }
    }
    
}
extension HomeServerApi {
    enum Result<T> {
        case success(data: T?)
        case failure(error: String)
    }
}

enum HomeError: Error {
    case server
    case client
    case network
}

extension HomeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .server:
            return "서버 Error"
        case .client:
            return "클라이언트 Error"
        case .network:
            return "네트워크 Error"
        }
    }
    public var failureReason: String? {
        switch self {
        case .client:
            return "서버 통신을 실패하였습니다. 다시 시도 부탁합니다."
        case .server:
            return "서버 통신이 불가 합니다. 서버에게 문의 부탁드립니다."
        case .network:
            return "통신이 불완전합니다. 확인 부탁합니다."
        }
    }
}
