//
//  AdvisoryApiService.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/29.
//

import Alamofire

//GET http://3.36.188.237:8080/Mypage/10Q10A/theme/{user}

let API_URL = "http://3.36.188.237:8080"
let userId = "1"

struct AdvisoryApiService {
    static func getAdvisoryAnswerList(completion: @escaping (AdvisoryList?) -> Void) {
        let urlComponent = URLComponents(string: "\(API_URL)/Mypage/10Q10A/theme/\(userId)")
        guard let url = urlComponent?.url else { return }
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                let stringResponse = String(data: response.data!, encoding: .utf8)

                let data = try! JSONDecoder().decode(AdvisoryList.self, from: Data(stringResponse!.data(using: .utf8)!))
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
