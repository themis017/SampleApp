//
//  SettingsViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation
import Combine
import UILayer

@MainActor
public class SettingsViewModel: ViewModel {
    
    public enum Action {
        case showSecondSettings
    }
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
   
    private let settingsUseCase: SettingsUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
   
    public init(settingsUseCase: SettingsUseCaseProviding) {
        self.randomProperty = settingsUseCase.randomProperty.value
        self.settingsUseCase = settingsUseCase
        
        bind(\.randomProperty, to: settingsUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: settingsUseCase.randomText)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showSecondSettings:
            settingsUseCase.showSecondSettingsScene()
        }
    }
    
}

#if DEBUG

public extension SettingsViewModel {
    
    static func previewViewModel() -> SettingsViewModel {
        let previewUseCase = PreviewSettingsUseCase()
        return SettingsViewModel(settingsUseCase: previewUseCase)
    }
}

#endif
