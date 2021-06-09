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
    
    static func getMyProfilePage(userId: Int,colorParameter: Parameters?,completionHandler: @escaping(Result<MyProfilePage>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/MyPage/\(userId)/")!
        AF.request(urlString, method: .get, parameters: colorParameter, encoding: URLEncoding.default)
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
                                let myProfileList = try decoder.decode(MyProfilePage.self, from: response)
                                let result = Result<MyProfilePage>.success(data: myProfileList)
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
    
    static func getMyProfileLikeList(userId: Int,crush: String,crushParameter: Parameters?, completionHandler: @escaping(Result<MyProfileLikeScrapList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/MyPage/CrushList/\(userId)/\(crush)")!
        AF.request(urlString, method: .get, parameters: crushParameter, encoding: URLEncoding.default)
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
                                let myProfileLikeList = try decoder.decode(MyProfileLikeScrapList.self, from: response)
                                let result = Result<MyProfileLikeScrapList>.success(data: myProfileLikeList)
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
    
    static func postMyProfileLikeProgress(likesParameter: LikeProgressParameter,completionHandler:@escaping(Result<LikeProgressList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/Board/likes/")!
        
        AF.request(urlString, method: .post, parameters: likesParameter, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(response):
                    do {
                        let jsonObejct = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObejct as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let myProfileLike = try decoder.decode(LikeProgressList.self, from: response)
                                let result = Result<LikeProgressList>.success(data: myProfileLike)
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
    
    
    static func postMyProfileScrapProgress(scrapParameter: ScrapProgressParameter, completionHandler: @escaping(Result<ScrapProgressList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/Board/scrap/")!
        
        AF.request(urlString, method: .post, parameters: scrapParameter, encoder: JSONParameterEncoder.default)
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
                                let myProfileScrap = try decoder.decode(ScrapProgressList.self, from: response)
                                let result = Result<ScrapProgressList>.success(data: myProfileScrap)
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
    
    
    static func putMyProfileShareProgress(cardSeq: Int, level: Int, completionHandler:@escaping(Result<ShareProgressList>) -> ()) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/Board/shares/\(cardSeq)/\(level)")!
        AF.request(urlString, method: .put, encoding: URLEncoding.default)
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
                                let myProfileShare = try decoder.decode(ShareProgressList.self, from: response)
                                let result = Result<ShareProgressList>.success(data: myProfileShare)
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
