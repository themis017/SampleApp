//
//  PasswordValidated.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation
import Combine

@propertyWrapper
public class PasswordValidated: ObservableObject {
    
    private var value: String = ""
    private let valueSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let errorSubject: PassthroughSubject<PasswordValueError?, Never> = PassthroughSubject()
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            valueSubject.send(newValue)
            errorSubject.send(Password.validatePassword(newValue))
        }
    }
    
    public var passwordPublisher: AnyPublisher<String, Never> {
        valueSubject
            .eraseToAnyPublisher()
    }
    
    public var passwordErrorPublisher: AnyPublisher<PasswordValueError?, Never> {
        errorSubject
            .eraseToAnyPublisher()
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
