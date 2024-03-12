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
    
    @Binding
    var isImagePickerPresented: Bool
    
    let sourceType: UIImagePickerController.SourceType
    
    public init(selectedImage: Binding<UIImage?>, 
                isImagePickerPresented: Binding<Bool>,
                sourceType: UIImagePickerController.SourceType = .photoLibrary) {
        
        self._selectedImage = selectedImage
        self._isImagePickerPresented = isImagePickerPresented
        self.sourceType = sourceType
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

            parent.isImagePickerPresented = false
        }

        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isImagePickerPresented = false
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
