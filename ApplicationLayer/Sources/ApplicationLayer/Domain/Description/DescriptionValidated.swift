//
//  DescriptionValidated.swift
//
//
//  Created by Themis Makedas on 13/2/24.
//

import Foundation
import Combine

@propertyWrapper
public class DescriptionValidated: ObservableObject {
    
    private var value: String = ""
    private let valueSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let errorSubject: PassthroughSubject<DescriptionValueError?, Never> = PassthroughSubject()
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            valueSubject.send(newValue)
            errorSubject.send(Description.validateDescription(newValue))
        }
    }
    
    public var descriptionPublisher: AnyPublisher<String, Never> {
        valueSubject
            .eraseToAnyPublisher()
    }
    
    public var descriptionErrorPublisher: AnyPublisher<DescriptionValueError?, Never> {
        errorSubject
            .eraseToAnyPublisher()
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
