//
//  UsernameValidated.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation
import Combine

@propertyWrapper
public class UsernameValidated: ObservableObject {
    
    private var value: String = ""
    private let valueSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let errorSubject: PassthroughSubject<UsernameValueError?, Never> = PassthroughSubject()
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            valueSubject.send(newValue)
            errorSubject.send(Username.validateUsername(newValue))
        }
    }
    
    public var usernamePublisher: AnyPublisher<String, Never> {
        valueSubject
            .eraseToAnyPublisher()
    }
    
    public var usernameErrorPublisher: AnyPublisher<UsernameValueError?, Never> {
        errorSubject
            .eraseToAnyPublisher()
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
