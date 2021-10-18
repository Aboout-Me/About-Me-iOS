import Foundation
import Alamofire

struct SettingApiService {
    
    //문의 처리 API
    static func postSendInquire(parameter: Parameters ,compltionHandler:@escaping((Result<SendInquireList>) -> ())) {
        let urlString: URL = URL(string: "http://3.36.188.237:8080/sendInquire")!
        
        
        AF.request(urlString, method: .post, parameters: parameter, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                debugPrint(response.result)
                switch response.result {
                case let .success(response):
                    do {
                        print("postSendInquire 성공")
                        let jsonObejct = try JSONSerialization.jsonObject(with: response, options: [])
                        if let jsonData = jsonObejct as? [String:Any] {
                            let code = jsonData["code"] as? Int
                            if code == 200 {
                                let decoder = JSONDecoder()
                                let sendInquireData = try decoder.decode(SendInquireList.self, from: response)
                                let result = Result<SendInquireList>.success(data: sendInquireData)
                                compltionHandler(result)
                            }
                        }
                    } catch {
                        print(error)
                    }
                    
                case let .failure(error):
                    print("postSendInquire 에러 : \(error)")
                    print(error.localizedDescription)
                }
            }
    }
    
    //알림 허용 API
    static func postAlertSetting(userId: Int, escapingHandler : @escaping (String) -> ()) -> Void {
        
        var status: Int = -1
        var body: String = ""
        
        let url = "\(API_URL)/Message/noti"
        
        let alertSettingParams = AlertSettingList(userId: userId)
        
        let request = AF.request(url, method: .post, parameters: alertSettingParams, encoder: URLEncodedFormParameterEncoder.default)
        request.validate(statusCode: 200...500).responseString { response in
            status = response.response!.statusCode
            switch response.result {
            case .success:
                print("postAlertSetting 성공")
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(AlertSettingResponse.self, from: data)
                        body = responseDecoded.body
                        
                        print("body 결과 : \(body)")
                        
                        escapingHandler(body)
                    }catch let error as NSError{
                        print(error)
                    }
                }
                
            case .failure(let error):
                print("postAlertSetting 실패")
                print(error)
                escapingHandler(body)
            }
        }
    }
    
    // MARK: - 로그인 : 카카오, 네이버
    
    static func getSignIn(authType: String, accessToken: String, escapingHandler : @escaping (Int, String) -> ()) -> Void {
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        let fcmToken = (appdelegate?.fcmtoken)!
        print("fcm :\(fcmToken)")
        
        let url = "\(API_URL)/auth/signin"
        var userIdForSignIn: Int = -1
        var nickName: String = ""
        
        let headers: HTTPHeaders = [
            "token": accessToken
        ]
        let signInParams = SignInList(type: authType, fcmToken: fcmToken)
        
        let request = AF.request(url, method: .get, parameters: signInParams, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("getSignIn 성공")
                print("response.value : \(response.value)")
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(SignInResponse.self, from: data)
                        userIdForSignIn = responseDecoded.userId
                        nickName = responseDecoded.nickName
                        
                        print(" ** userIdForSignIn \(userIdForSignIn)")
                        print(" ** nickNameForSignIn \(nickName)")
                        
                        escapingHandler(userIdForSignIn, nickName)
                    }catch let error as NSError{
                        print(error)
                    }
                }
                
            case .failure(let error):
                print("getSignIn 실패")
                print(error)
                escapingHandler(userIdForSignIn, nickName)
            }
        }
    }
}


extension SettingApiService {
    enum Result<T> {
        case success(data: T?)
        case failure(error: String)
    }
}
