//
//  FavouritesViewModel.swift
//
//
//  Created by Themis Makedas on 26/1/24.
//

import Foundation
import Combine
import ApplicationLayer
import UILayer

@MainActor
public class FavouritesViewModel: ViewModel {
    
    public enum Action {
        case nextAction
    }
    
    @Published
    var randomProperty: Int
    
    @Published
    var randomText: String = ""
    
    private let favouritesUseCase: FavouritesUseCaseProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(favouritesUseCase: FavouritesUseCaseProviding) {
        self.randomProperty = favouritesUseCase.randomProperty.value
        self.favouritesUseCase = favouritesUseCase
        
        bind(\.randomProperty, to: favouritesUseCase.randomProperty)
            .store(in: &subscriptions)
        
        forward($randomText, to: favouritesUseCase.randomText)
            .store(in: &subscriptions)
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .nextAction:
            favouritesUseCase.nextAction()
        }
    }
}

#if DEBUG

public extension FavouritesViewModel {
    
    static func previewViewModel() -> FavouritesViewModel {
        let previewUseCase = PreviewFavouritesUseCase()
        return FavouritesViewModel(favouritesUseCase: previewUseCase)
    }
}

#endif
