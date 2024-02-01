//
//  NameValidated.swift
//
//
//  Created by Themis Makedas on 1/2/24.
//

import Foundation
import Combine

@propertyWrapper
public class NameValidated: ObservableObject {
    
    private var value: String = ""
    private let valueSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let errorSubject: PassthroughSubject<NameValueError?, Never> = PassthroughSubject()
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            valueSubject.send(newValue)
            errorSubject.send(Name.validateName(newValue))
        }
    }
    
    public var namePublisher: AnyPublisher<String, Never> {
        valueSubject
            .eraseToAnyPublisher()
    }
    
    public var nameErrorPublisher: AnyPublisher<NameValueError?, Never> {
        errorSubject
            .eraseToAnyPublisher()
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
