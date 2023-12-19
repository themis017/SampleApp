//
//  SecondSettingsViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

@MainActor
public class SecondSettingsViewModel: ObservableObject {
    
    public enum Action {
        case dismiss
    }
   
    private let secondSettingsUseCase: SecondSettingsUseCaseProviding
   
    init(secondSettingsUseCase: SecondSettingsUseCaseProviding) {
        self.secondSettingsUseCase = secondSettingsUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .dismiss:
            secondSettingsUseCase.dismiss()
        }
    }
}

#if DEBUG

public extension SecondSettingsViewModel {
    
    static func previewViewModel() -> SecondSettingsViewModel {
        let previewUseCase = PreviewSecondSettingsUseCase()
        return SecondSettingsViewModel(secondSettingsUseCase: previewUseCase)
    }
}

#endif
