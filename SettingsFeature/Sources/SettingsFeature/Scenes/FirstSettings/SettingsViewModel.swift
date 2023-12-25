//
//  SettingsViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

@MainActor
public class SettingsViewModel: ObservableObject {
    
    public enum Action {
        case showSecondSettings
    }
   
    private let settingsUseCase: SettingsUseCaseProviding
   
    public init(settingsUseCase: SettingsUseCaseProviding) {
        self.settingsUseCase = settingsUseCase
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
