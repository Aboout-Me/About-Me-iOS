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
}


extension SettingApiService {
    enum Result<T> {
        case success(data: T?)
        case failure(error: String)
    }
}
