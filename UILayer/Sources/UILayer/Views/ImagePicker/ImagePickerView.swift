//
//  ImagePickerView.swift
//
//
//  Created by Themis Makedas on 12/3/24.
//

import Foundation
import SwiftUI

public struct ImagePickerView: UIViewControllerRepresentable {
   
    @Binding
    var selectedImage: UIImage?
    
    let sourceType: UIImagePickerController.SourceType
    
    private let onDismiss: () -> Void
    
    public init(selectedImage: Binding<UIImage?>, 
                sourceType: UIImagePickerController.SourceType = .photoLibrary,
                onDismiss: @escaping () -> Void) {
        
        self._selectedImage = selectedImage
        self.sourceType = sourceType
        self.onDismiss = onDismiss
    }

    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
//            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }

            parent.onDismiss()
        }

        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onDismiss()
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = sourceType
        return imagePickerController
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the UI if needed
    }
}
