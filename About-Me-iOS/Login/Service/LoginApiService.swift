import Alamofire
import SwiftKeychainWrapper

// POST http://3.36.188.237:8080/auth/signup
// GET http://3.36.188.237:8080/auth/signin

// API_URL = "http://3.36.188.237:8080"
// userId = 1

struct LoginApiService {
    
    // MARK: - 회원가입 : 카카오, 네이버
    
    static func postSignUp(authType: String, accessToken: String, escapingHandler : @escaping (Int, Int, String) -> ()) -> Void {
        
        var userIdForSignUp: Int = -1
        var status: Int = -1
        var userNickName: String = ""
        
        let url = "\(API_URL)/auth/signup"
        
        let headers: HTTPHeaders = [
            "token": accessToken
        ]
        let signUpParams = SignUpList(type: authType)
        
        let request = AF.request(url, method: .post, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            status = response.response!.statusCode
            switch response.result {
            case .success:
                print("postSignUp 성공")
                print(response.value)
                
                if response.response?.statusCode == 200 {
                    print("postSignUp : 200(신규회원)")
                    if let data = response.data {
                        do {
                            let responseDecoded = try JSONDecoder().decode(SignUpResponse.self, from: data)
                            userIdForSignUp = responseDecoded.userId
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
                    getSignIn(authType: authType, accessToken: accessToken){ (userIdForLogin, nickName) -> () in
                        userIdForSignUp = userIdForLogin
                        userNickName = nickName
                    }
                }
                else{
                    print("postSignUp : statusCode 오류")
                    print("status Code: \(response.response!.statusCode)")
                }
                
                escapingHandler(status, userIdForSignUp, userNickName)
                
            case .failure(let error):
                print("postSignUp 실패")
                print(error)
                
                escapingHandler(status, userIdForSignUp, userNickName)
            }
        }
    }
    
    // MARK: - 회원가입 : 애플
    
    static func postSignUpForApple(code: String, id_token: String, escapingHandler : @escaping (Int, Int) -> ()) -> Void {
        
        let url = "\(API_URL)/apple/auth/signUp"
        
        var userIdForSignUp: Int = -1
        var status: Int = -1
        
        let signUpParams = SignUpListForApple(code: code, id_token: id_token)
        
        let request = AF.request(url, method: .post, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default)
        
        request.validate(statusCode: 200...500).responseString { response in
            status = response.response!.statusCode
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
                            userIdForSignUp = responseDecoded.userId
                        }catch let error as NSError{
                            print(error)
                        }
                    }
                }
                else if response.response?.statusCode == 409 {
                    print("postSignUp : 409(기존유저->로그인)")
                    getSignInForApple(code: code, id_token: id_token){ (userIdForLogin) -> () in
                        userIdForSignUp = userIdForLogin
                    }
                }
                else{
                    print("postSignUp : statusCode 오류")
                }
                
                escapingHandler(status, userIdForSignUp)
                
            case .failure(let error):
                print("postSignUp 실패")
                print(error)
                
                escapingHandler(status, userIdForSignUp)
            }
        }
    }
    
    // MARK: - 로그인 : 카카오, 네이버
    
    static func getSignIn(authType: String, accessToken: String, escapingHandler : @escaping (Int, String) -> ()) -> Void {
        var appdelegate = UIApplication.shared.delegate as? AppDelegate
        let fcmToken = (appdelegate?.fcmtoken)!
        print("fcm :\(fcmToken)")
        
        let url = "\(API_URL)/auth/signin"
        var userIdForLogin: Int = -1
        var nickName: String = ""
        
        let headers: HTTPHeaders = [
            "token": accessToken
        ]
        print("at :\(accessToken)")
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
                        userIdForLogin = responseDecoded.userId
                        nickName = responseDecoded.nickName
                        print(" ** userIdForLogin \(userIdForLogin)")
                    }catch let error as NSError{
                        print(error)
                    }
                }
                escapingHandler(userIdForLogin, nickName)
                
            case .failure(let error):
                print("getSignIn 실패")
                print(error)
                escapingHandler(userIdForLogin, nickName)
            }
        }
    }
    
    // MARK: - 로그인 : 애플
    
    static func getSignInForApple(code: String, id_token: String, escapingHandler : @escaping (Int) -> ()) -> Void {
        
        let url = "\(API_URL)/apple/auth/login"
        var userIdForLogin: Int = -1
        
        let signUpParams = SignUpListForApple(code: code, id_token: id_token)
        
        let request = AF.request(url, method: .get, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("getSignIn 성공")
                print("response.value : \(response.value)")
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(SignInResponse.self, from: data)
                        userIdForLogin = responseDecoded.userId
                    }catch let error as NSError{
                        print(error)
                    }
                }
                escapingHandler(userIdForLogin)
                
            case .failure(let error):
                print("getSignIn 실패")
                print(error)
                escapingHandler(userIdForLogin)
            }
        }
    }
    
    // MARK: - 회원정보추가(회원가입 시)
    
    static func putProfileForSignUp(birthday: String, email: String, nickName: String, gender: String, introduce: String, userId: Int)
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
                print("putProfileForSignUp 성공")
                print(response.value)
                
            case .failure(let error):
                print("putProfileForSignUp 실패")
                print(error)
            }
        }
    }
    
    // MARK: - 회원정보수정(설정)
    
    static func putProfileForEditing(nickName: String, introduce: String, userId: Int)
    {
        let url = "\(API_URL)/MyPage/profile"
        
        let parameters: Parameters = [
            "introduce": introduce,
            "nickName": nickName,
            "userId": userId
        ]
        
        let request = AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
        
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("putProfileForEditing 성공")
                print(response.value)
                
            case .failure(let error):
                print("putProfileForEditing 실패")
                print(error)
            }
        }
    }
}
