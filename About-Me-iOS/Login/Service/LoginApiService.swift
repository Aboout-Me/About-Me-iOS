import Alamofire

// POST http://3.36.188.237:8080/auth/signup
// GET http://3.36.188.237:8080/auth/signin

// API_URL = "http://3.36.188.237:8080"
// userId = 1

var flag = -2

struct LoginApiService {
    
    static func postSignUp(authType: String, accessToken: String, escapingHandler : @escaping (Int) -> ()) -> Void {
        
        let url = "\(API_URL)/auth/signup"
        
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Accept": "application/json"
        ]
        let signUpParams = SignUpList(AuthType: authType)
    
        let request = AF.request(url, method: .post, parameters: signUpParams, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print("postSignUp 성공")
                print(response.value)
                
                flag = 0
                
                escapingHandler(flag)
                
            case .failure(let error):
                print("postSignUp 실패, getSignIn 진입")
                print(error)
                
                // response가 error반환 시 기존유저 -> 로그인 진입
                getSignIn(authType: authType, accessToken: accessToken)
                
                flag = 1
                
                escapingHandler(flag)
            }
        }
    }
    
    static func getSignIn(authType: String, accessToken: String) {
     
        let url = "\(API_URL)/auth/signin"
        
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Accept": "application/json"
        ]
        let signUpParams = SignUpList(AuthType: authType)
    
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
    
    static func putProfile(email: String, nickname: String, introduce: String, color: String, date: String, gender: String)
 {
     
        let url = "\(API_URL)/MyPage/profile"
        let profileParams = ProfileList(email: email, nickname: nickname, introduce: introduce, color: color, date: date, gender: gender)
        
        let request = AF.request(url, method: .put, parameters: profileParams, encoder: URLEncodedFormParameterEncoder.default)
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
