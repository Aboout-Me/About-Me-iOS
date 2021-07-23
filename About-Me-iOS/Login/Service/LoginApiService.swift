import Alamofire
import SwiftKeychainWrapper

// POST http://3.36.188.237:8080/auth/signup
// GET http://3.36.188.237:8080/auth/signin

// API_URL = "http://3.36.188.237:8080"
// userId = 1

var flag = -1

struct LoginApiService {
    
    static func postSignUp(authType: String, accessToken: String, escapingHandler : @escaping (Int) -> ()) -> Void {
        
        let url = "\(API_URL)/auth/signup"
        
        let headers: HTTPHeaders = [
            "token": accessToken
        ]
        let signUpParams = SignUpList(type: authType)

        let request = AF.request(url, method: .post, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("postSignUp 성공")
                print(response.value)
                
                if response.response?.statusCode == 200 {
                    print("postSignUp : 200(신규회원)")
                    if let data = response.data {
                        do {
                            let responseDecoded = try JSONDecoder().decode(SignUpResponse.self, from: data)
                            flag = responseDecoded.userId
                        }catch let error as NSError{
                            print(error)
                        }
                    }
                }
                else if response.response?.statusCode == 401 {
                    print("postSignUp : 401(인증에러)")
                }
                else if response.response?.statusCode == 404 {
                    print("postSignUp : 404(없는 유저의 로그인)")
                }
                else if response.response?.statusCode == 409 {
                    print("postSignUp : 409(기존유저->로그인)")
                    flag = 0
                    getSignIn(authType: authType, accessToken: accessToken)
                }
                else{
                    print("postSignUp : statusCode 오류")
                    print("status Code: \(response.response?.statusCode)")
                }
                
                escapingHandler(flag)
                
            case .failure(let error):
                print("postSignUp 실패")
                print(error)
                
                escapingHandler(flag)
                }
            }
        }
    
    static func postSignUpForApple(code: String, id_token: String, escapingHandler : @escaping (Int) -> ()) -> Void {
        
        let url = "\(API_URL)/apple/auth/signUp"
        let userId: Int = -1
     
        let signUpParams = SignUpListForApple(code: code, id_token: id_token)

        let request = AF.request(url, method: .post, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("postSignUp 성공")
                print(response.value)
                
                if response.response?.statusCode == 401 {
                    print("postSignUp : 401(인증에러)")
                }
                else if response.response?.statusCode == 404 {
                    print("postSignUp : 404(신규회원)")
                    if let data = response.data {
                        print("postSignUp response : \(data)")
                        do {
                            let responseDecoded = try JSONDecoder().decode(SignUpResponse.self, from: data)
                            flag = responseDecoded.userId
                        }catch let error as NSError{
                            print(error)
                        }
                    }
                }
                else if response.response?.statusCode == 409 {
                    print("postSignUp : 409(기존유저->로그인)")
                    flag = 0
                    getSignInForApple(code: code, id_token: id_token)
                }
                else{
                    print("postSignUp : statusCode 오류")
                }
                
                escapingHandler(flag)
                
            case .failure(let error):
                print("postSignUp 실패")
                print(error)
                
                escapingHandler(flag)
                }
            }
        }
    
    static func getSignIn(authType: String, accessToken: String) {
     
        let url = "\(API_URL)/auth/signin"
        
        let headers: HTTPHeaders = [
            "token": accessToken
        ]
        let signUpParams = SignUpList(type: authType)
    
        let request = AF.request(url, method: .get, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("getSignIn 성공")
                print(response.value)
                
            case .failure(let error):
                print("getSignIn 실패")
                print(error)
            }
        }
    }
    
    static func getSignInForApple(code: String, id_token: String) {
     
        let url = "\(API_URL)/apple/auth/login"

        let signUpParams = SignUpListForApple(code: code, id_token: id_token)
    
        let request = AF.request(url, method: .get, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("getSignIn 성공")
                print(response.value)
                
            case .failure(let error):
                print("getSignIn 실패")
                print(error)
            }
        }
    }
    
    static func putProfile(birthday: String, email: String, nickName: String, gender: String, introduce: String, userId: Int)
 {
        let url = "\(API_URL)/MyPage/profile"
        // let profileParams = ProfileList(email: email, gender: gender, introduce: introduce, nickName: nickName, userId: userId)
        
        let parameters: Parameters = [
            "birthday": birthday,
            "email": email,
            "gender": gender,
            "introduce": introduce,
            "nickName": nickName,
            "userId": userId
        ]

        
        let request = AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)

        
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("putProfile 성공")
                print(response.value)

            case .failure(let error):
                print("putProfile 실패")
                print(error)
            }
        }
    }
}
