//
//  UnauthorizedPhotoLibraryView.swift
//
//
//  Created by Themis  on 19/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UnauthorizedPhotoLibraryView: View {
    
    public static let sceneIdentity = "UnauthorizedPhotoLibraryView"
    
    private let onDismiss: () -> Void
    
    public init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                
                Text("You need to provides access in order to upload a photo from your photo library!")
                    .font(.title2)
                    .padding(.top, 32)
                
                Link("Go to settings", destination: URL(string: UIApplication.openSettingsURLString)!)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("Photo library authorization")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        onDismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

#if DEBUG

struct UnauthorizedPhotoLibraryView_Previews: PreviewProvider {
    
    static var previews: some View {
        UnauthorizedPhotoLibraryView {
            print("Dismiss")
        }
    }
}

#endif
