////
////  NotificationsViewModel.swift
////
////
////  Created by Themis Makedas on 24/1/24.
////
//
//import Foundation
//import Combine
//import ApplicationLayer
//import UILayer
//
//@MainActor
//public class NotificationsViewModel: ViewModel {
//    
//    public enum Action {
//        case nextAction
//    }
//    
//    @Published
//    var randomProperty: Int
//    
//    @Published
//    var randomText: String = ""
//    
//    private let notificationsUseCase: NotificationsUseCaseProviding
//    
//    private var subscriptions: Set<AnyCancellable> = []
//    
//    public init(notificationsUseCase: NotificationsUseCaseProviding) {
//        self.randomProperty = notificationsUseCase.randomProperty.value
//        self.notificationsUseCase = notificationsUseCase
//        
//        bind(\.randomProperty, to: notificationsUseCase.randomProperty)
//            .store(in: &subscriptions)
//        
//        forward($randomText, to: notificationsUseCase.randomText)
//            .store(in: &subscriptions)
//    }
//    
//    public func perform(_ action: Action) {
//        switch action {
//        case .nextAction:
//            notificationsUseCase.nextAction()
//        }
//    }
//}
//
//#if DEBUG
//
//public extension NotificationsViewModel {
//    
//    static func previewViewModel() -> NotificationsViewModel {
//        let previewUseCase = PreviewNotificationsUseCase()
//        return NotificationsViewModel(notificationsUseCase: previewUseCase)
//    }
//}
//
//#endif
