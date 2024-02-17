//
//  LandingUseCase.swift
//
//
//  Created by Themis Makedas on 27/1/24.
//

import Foundation
import ApplicationLayer

public protocol LandingUseCaseProviding {}

public class LandingUseCase: LandingUseCaseProviding {
    
    private let mainRouter: any MainRouting
    
    public init(mainRouter: any MainRouting) {
        self.mainRouter = mainRouter
        
        loadRegisterInfo()
    }
    
    private func loadRegisterInfo() {
        let enableAutoLogin = AppData.shared.value(of: .enableAutoLogin) ?? false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            guard enableAutoLogin else {
                self.mainRouter.showEntryPointScene()
                return
            }
                        
            self.loadUserProfile()
            self.mainRouter.showMainScene()
        }
    }
    
    private func loadUserProfile() {
        AppData.shared.save(UserProfile.user_1, to: .userProfile)
    }
}

#if DEBUG

public class PreviewLandingUseCase: LandingUseCaseProviding {}

#endif
