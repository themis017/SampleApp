//
//  LandingViewModel.swift
//
//
//  Created by Themis Makedas on 27/1/24.
//

import Foundation

@MainActor
public class LandingViewModel: ObservableObject {
    
    private let landingUseCase: LandingUseCaseProviding
   
    public init(landingUseCase: LandingUseCaseProviding) {
        self.landingUseCase = landingUseCase
    }
}

#if DEBUG

public extension LandingViewModel {
    
    static func previewViewModel() -> LandingViewModel {
        let previewUseCase = PreviewLandingUseCase()
        return LandingViewModel(landingUseCase: previewUseCase)
    }
}

#endif
