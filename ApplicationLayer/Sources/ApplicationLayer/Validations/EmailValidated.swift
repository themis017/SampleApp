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
    private let subject: PassthroughSubject<String, Never> = PassthroughSubject()
    private var isValid: Bool = false
    
    public var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue
            subject.send(newValue)
            isValid = validateEmail(newValue)
        }
    }
    
    public var emailPublisher: AnyPublisher<String, Never> {
        subject
            .eraseToAnyPublisher()
    }
    
    var isValidEmail: Bool {
        return isValid
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    
    private func validateEmail(_ email: String) -> Bool {
        // Implement your email validation logic here
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}


//@propertyWrapper
//public struct EmailValidated {
//    private var value: String = ""
//    private var isValid: Bool = false
//
//    public var wrappedValue: String {
//        get { value }
//        set {
//            value = newValue
//            isValid = validateEmail(newValue)
//        }
//    }
//
//    var isValidEmail: Bool {
//        return isValid
//    }
//
//    public init(wrappedValue: String) {
//        self.wrappedValue = wrappedValue
//    }
//
//    private func validateEmail(_ email: String) -> Bool {
//        // Implement your email validation logic here
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//        return emailPredicate.evaluate(with: email)
//    }
//}


//@propertyWrapper
//public struct EmailValidated {
//    private(set) var defaultValue: String = ""
//
//    public var wrappedValue: String {
//        get {
//            defaultValue
//        }
//
//        set { defaultValue = maxLength(newValue) //&& isValid(newValue)
//            ?
//                newValue
//            :
//            "" }
//    }
//
//    public init(wrappedValue initialValue: String) {
//        self.wrappedValue = initialValue
//    }
//
////    private func isValid(emailAddress: String) -> Bool {
////        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
////            + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
////            + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
////            + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
////            + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
////            + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
////            + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
////
////        let emailValidation = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
////        return emailValidation.evaluate(with: emailAddress)
////    }
//
//    private func maxLength(_ emailAddress: String) -> Bool {
//        guard emailAddress.count <= 80 else {
//            return false
//        }
//
//        guard let domainKey = emailAddress.firstIndex(of: "@") else { return false }
//
//        return emailAddress[..<domainKey].count <= 64
//    }
//}
