//
//  HomeBeforeViewModel.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2022/01/15.
//

import RxCocoa
import RxSwift
import RxTest


protocol HomeBeforeViewModelType: AnyObject {
    associatedtype Input
    associatedtype Ouput
    
    var input: Input { get }
    var ouput: Ouput { get }
}


class HomeBeforeViewModel: HomeBeforeViewModelType {
    
    struct Input {
        var homeBeforeTrigger = PublishSubject<Void>()
    }
    
    struct Ouput {
        var homeBeforeBottomTrigger = PublishRelay<Void>()
    }
    
    //MARK: Property
    var input = Input()
    var ouput = Ouput()
    
    
    init() {
        
    }
    //MARK: initalize
    
    
}


