//
//  ViewModel.swift
//
//
//  Created by Themis Makedas on 11/1/24.
//

import Foundation
import Combine
import SwiftUI

public protocol ViewModel: ObservableObject {}

public extension ViewModel {
    
    func bind<V: Equatable>(_ property: ReferenceWritableKeyPath<Self, V>, to observable: Observable<V>, animatedBy animation: Animation? = nil) -> AnyCancellable {
        observable
            .publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                withAnimation(animation) {
                    self?[keyPath: property] = newValue
                }
            }
    }
    
    func forward<V: Equatable>(_ publishedValue: Published<V>.Publisher, to observable: Observable<V>) -> AnyCancellable {
        publishedValue
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { newValue in
                observable.value = newValue
            }
    }
    
    func forward<V: Equatable>(_ publishedValue: AnyPublisher<V, Never>, to observable: Observable<V>) -> AnyCancellable {
        publishedValue
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { newValue in
                observable.value = newValue
            }
    }
}
