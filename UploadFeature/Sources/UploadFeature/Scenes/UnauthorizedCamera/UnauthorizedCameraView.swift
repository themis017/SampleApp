//
//  UnauthorizedCameraView.swift
//
//
//  Created by Themis  on 19/3/24.
//

import Foundation
import SwiftUI
import UILayer

public struct UnauthorizedCameraView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    public static let sceneIdentity = "UnauthorizedCameraView"
    
    @Binding
    var isUnauthorizedCameraPresented: Bool
    
    public init(isUnauthorizedCameraPresented: Binding<Bool>) {
        self._isUnauthorizedCameraPresented = isUnauthorizedCameraPresented
    }
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                
                Text("You need to provides access in order to take a photo with your camera!")
                    .font(.title2)
                    .padding(.top, 32)
                
                Link("Go to settings", destination: URL(string: UIApplication.openSettingsURLString)!)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("Camera authorization")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isUnauthorizedCameraPresented = false
                        presentationMode.wrappedValue.dismiss()
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

struct UnauthorizedCameraView_Previews: PreviewProvider {
    
    static var previews: some View {
        UnauthorizedCameraView(isUnauthorizedCameraPresented: .constant(true))
    }
}

#endif