//
//  FirstSettingsViewModel.swift
//
//
//  Created by Themis Makedas on 19/12/23.
//

import Foundation

@MainActor
public class FirstSettingsViewModel: ObservableObject {
    
    public enum Action {
        case showSecondSettings
    }
   
    private let firstSettingsUseCase: FirstSettingsUseCaseProviding
   
    public init(firstSettingsUseCase: FirstSettingsUseCaseProviding) {
        self.firstSettingsUseCase = firstSettingsUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showSecondSettings:
            firstSettingsUseCase.showSecondSettingsScene()
        }
    }
    
}

#if DEBUG

public extension FirstSettingsViewModel {
    
    static func previewViewModel() -> FirstSettingsViewModel {
        let previewUseCase = PreviewFirstSettingsUseCase()
        return FirstSettingsViewModel(firstSettingsUseCase: previewUseCase)
    }
}

#endif
