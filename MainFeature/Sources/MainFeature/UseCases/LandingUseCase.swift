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
        
        loadLandingInfo()
    }
    
    private func loadLandingInfo() {
        let enableAutoLogin = AppData.shared.value(of: .enableAutoLogin) ?? false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            guard enableAutoLogin else {
                self.mainRouter.showEntryPointScene()
                return
            }
                        
            self.loadUserProfile()
            self.loadFavourites()
            self.mainRouter.showMainScene()
        }
    }
    
    private func loadUserProfile() {
        let userProfile: UserProfile? = AppData.shared.value(of: .userProfile)
        if userProfile == nil {
            AppData.shared.save(UserProfile.principalUser, to: .userProfile)
        }
    }
    
    private func loadFavourites() {
        let favourites: [Recipe]? = AppData.shared.value(of: .favourites)
        if favourites == nil {
            AppData.shared.save(Recipe.previewFavouritesExamples, to: .favourites)
        }
    }
}

#if DEBUG

public class PreviewLandingUseCase: LandingUseCaseProviding {}

#endif
