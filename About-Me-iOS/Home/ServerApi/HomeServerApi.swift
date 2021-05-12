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
                        let result = Result<HomeCardList>.failure(error: error.localizedDescription)
                        completionHandler(result)
                    }
                case let .failure(error):
                    let result = Result<HomeCardList>.failure(error: error.localizedDescription)
                    completionHandler(result)
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
                        let result = Result<HomeCardSaveList>.failure(error: error.localizedDescription)
                        completionHandler(result)
                    }
                case let .failure(error):
                    let result = Result<HomeCardSaveList>.failure(error: error.localizedDescription)
                    completionHandler(result)
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
                        let result = Result<HomeCardDeleteList>.failure(error: error.localizedDescription)
                        completionHandler(result)
                    }
                case let .failure(error):
                    let result = Result<HomeCardDeleteList>.failure(error: error.localizedDescription)
                    completionHandler(result)
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
