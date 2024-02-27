//
//  SearchUseCase.swift
//
//
//  Created by Themis Makedas on 24/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

public protocol SearchUseCaseProviding {
    
//    var temp: Observable<Int?> { get }
        
    func action()
}

public class SearchUseCase: SearchUseCaseProviding {
    
//    public let temp: Observable<Int?>
        
    private var subscriptions: Set<AnyCancellable> = []
    
    private let searchRouter: any SearchRouting
    
    public init(searchRouter: any SearchRouting) {
        
        
//        self.temp = Observable(initialValue: AppData.shared.value(of: .temp))
//        print("###1 \(self.temp.value)")
        
        self.searchRouter = searchRouter
        
//        AppData.shared
//            .tempPublisher
//            .sink { [weak self] newValue in
//                print("###2 \(newValue)")
//            }
//            .store(in: &subscriptions)
    }
    
    public func action() {
//        let currentValue = temp.value ?? 0
//        temp.value = currentValue + 1
//        AppData.shared.save(temp.value, to: .temp)
    }
    
}

#if DEBUG

public class PreviewSearchUseCase: SearchUseCaseProviding {
    
//    public var temp: Observable<Int?>
        
    public init() {
//        self.temp = Observable(initialValue: 0)
    }
    
    public func action() {}
}

#endif
