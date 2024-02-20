//
//  RecipeResultRow.swift
//
//
//  Created by Themis Makedas on 20/2/24.
//
 
import SwiftUI
import ApplicationCore

public struct RecipeResultRow<Accessory: View>: View {
    
    @Environment(\.showPlaceholders)
    private var showPlaceholders
    
    @Environment(\.socialActionsAvailability)
    private var socialActionsAvailability
    
    let result: UserSearchResult
    let accessory: () -> Accessory
    
    public init(result: UserSearchResult) where Accessory == EmptyView {
        
        self.result = result
        self.accessory = { EmptyView() }
    }
    
    public init(result: UserSearchResult,
                @ViewBuilder accessory: @escaping () -> Accessory) {
        
        self.result = result
        self.accessory = accessory
    }
    
    var name: String {
        guard let fullname = result.fullname?.rawValue else {
            let firstname = result.firstname?.rawValue ?? "-"
            let lastname = result.lastname?.rawValue ?? "-"
            return firstname + " " + lastname
        }
        
        return fullname
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            avatar
            
            Stack(axis: socialActionsAvailability == .all ? .vertical : .horizontal, spacing: 16) {
                userContent
                
                accessory()
                    .padding(.top, socialActionsAvailability != .all ? 8 : 0)
            }
        }
        .metaInformationContainer()
        .placeholder()
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var avatar: some View {
        if showPlaceholders {
            Circle()
                .foregroundColor(.placeholderColor)
                .frame(width: 48, height: 48)
            
        } else {
            UserAvatar(
                size: .medium,
                userSearchResult: result
            )
            .metaInformationContent(.icon)
        }
    }
    
    @ViewBuilder
    private var userContent: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text(name)
                .textStyle(.bodyTitle)
                .foregroundColor(.textPrimary)
                .metaInformationContent(.title)
            
            Text(result.username?.rawValue ?? "-")
                .textStyle(.body)
                .foregroundColor(.textSecondary)
                .metaInformationContent(.subtitle)
        }
        .metaInformationContainer()
        .frame(maxWidth: .infinity, alignment: .leading)
        .lineLimit(1)
        .padding(.top, 8)
        .background(TransparentTouchTarget())
        .placeholder()
    }
}
