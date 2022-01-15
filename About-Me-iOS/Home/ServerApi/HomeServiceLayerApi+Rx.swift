//
//  HomeServiceLayerApi + Rx.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2022/01/16.
//

import RxSwift
import RxCocoa
import RxTest
import Alamofire


//MARK: - HomeServiceLayer : 가공한 데이터를 Subscibe 구독을 통해 데이터 전달
protocol HomeServiceLayer {
    func requestCardList(
        userId: Int) -> Observable<HomeCardList>
}

//MARK: - NetworkCenterProtocol : 요기서 파싱을 통해 데이터를 가공
protocol NetworkCenterProtocol {
    static func fetchHomeCardList(userId: Int) -> Observable<HomeCardList>
}

struct HomeServiceLayerApi: HomeServiceLayer {

    private let disposeBag = DisposeBag()
    
    func requestCardList(userId: Int) -> Observable<HomeCardList> {
        return Observable<HomeCardList>.create { ob in
            NetworkCenterLayer.fetchHomeCardList(userId: USER_ID)
                .subscribe { res in
                    ob.onNext(res)
                } onError: { error in
                    ob.onError(error)
                } onCompleted: {
                    ob.onCompleted()
                }.disposed(by: disposeBag)
            return Disposables.create()
        }
        
    }
}

struct NetworkCenterLayer: NetworkCenterProtocol {
    
    static func fetchHomeCardList(userId: Int) -> Observable<HomeCardList> {
        return Observable<HomeCardList>.create { ob -> Disposable in
            let res = AF.request("http://3.36.188.237:8080/Board/dailyColors/\(userId)"
                                 , method: .get,
                                 encoding: JSONEncoding.prettyPrinted
                                 )
            res.responseData { response in
                switch response.result {
                
                case let .success(response):
                    do {
                        let decoder = try JSONDecoder().decode(HomeCardList.self, from: response)
                        ob.onNext(decoder)
                    } catch {
                        ob.onError(error)
                    }
                case .failure(_):
                    let errorCode = response.response?.statusCode
                    ob.onError(AboutMeError(code:errorCode))
                }
            }
            return Disposables.create()
        }
    }
        
}










struct AboutMeError: Error {
    var code: Int?
    private var message: String?
    
    init(code: Int? = nil, message: String? = nil) {
        self.code = code
        self.message = message
    }
    
    //MARK: - Error Handling
    static var notFoundUserError: AboutMeError {
        return AboutMeError(message: "해당 유저가 존재하지 않습니다.")
    }
    
    static var AnswerIsExpiredError: AboutMeError {
        return AboutMeError(message: "해당 글의 지난 응답이 존재하지가 않습니다.")
    }
    
}

