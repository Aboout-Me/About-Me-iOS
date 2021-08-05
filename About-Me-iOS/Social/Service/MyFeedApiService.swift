//
//  MyFeedApiService.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/07.
//

import Alamofire

struct MyFeedApiService {
    static func getFeedList(color: String?, completion: @escaping ([FeedPost]?) -> Void) {
        var urlString = "\(API_URL)/MyPage/PostList/\(userId)"
        if let color = color, color != "" {
            urlString.append("?color=\(color)")
        }
        
        let urlComponent = URLComponents(string: urlString)
        guard let url = urlComponent?.url else { return }
        print(url)
        
        let request = AF.request(url, method: .get)
        request.validate(statusCode: 200...500).responseString { response in
            switch response.result {
            case .success:
                let stringResponse = String(data: response.data!, encoding: .utf8)
                print(stringResponse)

                do {
                    let data = try JSONDecoder().decode(MyFeedResponse.self, from: Data(stringResponse!.data(using: .utf8)!))
                    completion(data.postList)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
