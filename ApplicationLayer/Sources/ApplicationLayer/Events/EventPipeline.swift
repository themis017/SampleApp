//
//  EventPipeline.swift
//
//
//  Created by Themis Makedas on 25/11/23.
//

import Foundation
import Combine

public class EventPipeline {
    
    public static let shared = EventPipeline()
    
    private let subject = PassthroughSubject<AppEvent, Never>()
    
    public var eventPublisher: AnyPublisher<AppEvent, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public init() {}
    
    public func send<E: AppEvent>(_ event: E) {
        subject.send(event)
    }
}
