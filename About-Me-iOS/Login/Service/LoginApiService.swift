import Alamofire

// POST http://3.36.188.237:8080/auth/signup
// GET http://3.36.188.237:8080/auth/signin

// API_URL = "http://3.36.188.237:8080"
// userId = 1

struct LoginApiService {
    
    static func postSignUp(authType: String, accessToken: String) -> Int {
        
        var flag: Int = -1
        
        let url = "\(API_URL)/auth/signup"
        
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        guard let additionalProfileVC = storyboard.instantiateViewController(withIdentifier: "AdditionalProfileViewController")
//                as? AdditionalProfileViewController else { return }
        
        let headers: HTTPHeaders = [
            "access token": accessToken
        ]
        let signUpParams = SignUpList(AuthType: authType, auth_yn: 0)
    
        let request = AF.request(url, method: .post, parameters: signUpParams, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("postSignUp 성공")
                print(response.value)
                
                flag = 0
                
            case .failure(let error):
                print(error)
                // signin에서 error반환 시 기존유저 -> 로그인 진입
                getSignIn(authType: authType, accessToken: accessToken)
                
                flag = 1
            }
        }
        
        return flag
    }
    
    static func getSignIn(authType: String, accessToken: String) {
     
        let url = "\(API_URL)/auth/signin"
        
        let headers: HTTPHeaders = [
            "access token": accessToken
        ]
        let signUpParams = SignUpList(AuthType: authType, auth_yn: 0)
    
        let request = AF.request(url, method: .get, parameters: signUpParams, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("getSignIn 성공")
                print(response.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func putProfile() {
     
        let url = "\(API_URL)/MyPage/profile"
        
    }
}
