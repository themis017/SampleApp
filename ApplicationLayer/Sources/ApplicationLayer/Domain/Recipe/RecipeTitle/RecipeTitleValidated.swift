//
//  RecipeTitleValidated.swift
//
//
//  Created by Themis  on 30/3/24.
//

import Foundation
import Combine

@propertyWrapper
public class RecipeTitleValidated: ObservableObject {
    
    private var value: String = ""
    private let valueSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let errorSubject: PassthroughSubject<RecipeTitleValueError?, Never> = PassthroughSubject()
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            valueSubject.send(newValue)
            errorSubject.send(RecipeTitle.validateRecipeTitle(newValue))
        }
    }
    
    public var recipeTitlePublisher: AnyPublisher<String, Never> {
        valueSubject
            .eraseToAnyPublisher()
    }
    
    public var recipeTitleErrorPublisher: AnyPublisher<RecipeTitleValueError?, Never> {
        errorSubject
            .eraseToAnyPublisher()
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
