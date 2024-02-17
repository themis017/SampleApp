////
////  NotificationsView.swift
////
////
////  Created by Themis Makedas on 24/1/24.
////
//
//import Foundation
//import SwiftUI
//
//public struct NotificationsView: View {
//    
//    @ObservedObject
//    private var viewModel: NotificationsViewModel
//    
//    public static let sceneIdentity = "NotificationsView"
//    
//    public init(viewModel: NotificationsViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    public var body: some View {
//        
//        VStack(spacing: 16) {
//            Text("NotificationsView")
//                .padding(16)
//                .foregroundColor(.white)
//                .background(Color.yellow)
//            
//            Spacer()
//            
//            Button {
//                viewModel.perform(.nextAction)
//            } label: {
//                Text("Next")
//                    .padding(24)
//                    .background(Color.orange)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//            }
//            
//
//        }
//        .background(Color.green)
//    }
//}
//
//#if DEBUG
//
//struct NotificationsView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        NotificationsView(viewModel: .previewViewModel())
//    }
//}
//
//#endif
