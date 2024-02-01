//
//  EmailValidated.swift
//  
//
//  Created by Themis Makedas on 31/1/24.
//

import Foundation
import Combine

@propertyWrapper
public class EmailValidated: ObservableObject {
    
    private var value: String = ""
    private let valueSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let errorSubject: PassthroughSubject<EmailValueError?, Never> = PassthroughSubject()
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            valueSubject.send(newValue)
            errorSubject.send(Email.validateEmail(newValue))
        }
    }
    
    public var emailPublisher: AnyPublisher<String, Never> {
        valueSubject
            .eraseToAnyPublisher()
    }
    
    public var emailErrorPublisher: AnyPublisher<EmailValueError?, Never> {
        errorSubject
            .eraseToAnyPublisher()
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
