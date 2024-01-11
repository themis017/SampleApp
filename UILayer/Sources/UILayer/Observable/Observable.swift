//
//  Observable.swift
//
//
//  Created by Themis Makedas on 11/1/24.
//

import Foundation
import Combine

public final class Observable<Value: Equatable> {
    
    private let subject: PassthroughSubject<Value, Never>
    
    private var valueStorage: Value
    public var value: Value {
        get {
            valueStorage
        }
        
        set {
            valueStorage = newValue
            subject.send(newValue)
        }
    }
    
    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public required init(initialValue: Value) {
        self.valueStorage = initialValue
        self.subject = PassthroughSubject()
    }
    
    // MARK: Bidning & Observations
    
    public func notifyValueChanged() {
        self.subject.send(valueStorage)
    }
}
