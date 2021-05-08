//
//  HomeServerApi.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/08.
//

import Alamofire
import UIKit


struct HomeServerApi {
    static func getHomeCardList(userId:Int, completionHandler:@escaping(Result<HomeCardList>) -> ()) {
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
                        let requestFailure = Result<HomeCardList>.ErrorType.requestFailure(error: error)
                        let result = Result<HomeCardList>.failure(type: requestFailure)
                        completionHandler(result)
                    }
                case let .failure(error):
                    let requestFailure = Result<HomeCardList>.ErrorType.requestFailure(error: error)
                    let result = Result<HomeCardList>.failure(type: requestFailure)
                    completionHandler(result)
                }
            }
    }
}

extension HomeServerApi {
    enum Result<T> {
        case success(data: T?)
        case failure(type: ErrorType)
    }
}

extension HomeServerApi.Result {
    enum ErrorType {
        case requestFailure(error: Error)
        case logicalError(code: Int, data:Any?, alertTitle:String?, alertMessage: String?)
        case sessionEnd(code: Int)
    }
}
