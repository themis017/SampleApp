//
//  EntryPointViewModel.swift
//
//
//  Created by Themis Makedas on 25/12/23.
//

import Foundation

@MainActor
public class EntryPointViewModel: ObservableObject {
    
    public enum Action {
        case showHome
    }
    
    private let entryPointUseCase: EntryPointUseCaseProviding
   
    public init(entryPointUseCase: EntryPointUseCaseProviding) {
        self.entryPointUseCase = entryPointUseCase
    }
    
    public func perform(_ action: Action) {
        switch action {
        case .showHome:
            entryPointUseCase.showHomeScene()
        }
    }
}

#if DEBUG

public extension EntryPointViewModel {
    
    static func previewViewModel() -> EntryPointViewModel {
        let previewUseCase = PreviewEntryPointUseCase()
        return EntryPointViewModel(entryPointUseCase: previewUseCase)
    }
}

#endif
