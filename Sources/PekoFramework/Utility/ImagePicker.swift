//
//  ImagePicker.swift
//
//
//  Created by Lukáš Spurný on 19.03.2024.
//

import SwiftUI

@available(iOS 16.4, *)
public extension View {
    func imagePicker() -> some View {
        self.modifier(ImagePickerModifier())
    }
}

@available(iOS 16.4, *)
struct ImagePickerModifier: ViewModifier {
    
    @EnvironmentObject private var pekoConfigurations: PekoConfigurations
    
    @State var showPicker: Bool = false
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $showPicker, content: {
                ImagePickerSwiftUI(
                    selectedImage: $pekoConfigurations.selectedImage,
                    sourceType: pekoConfigurations.selectedSourceCamera,
                  allowsEditing: true
                )
                .presentationBackground(Color.black)
            })
            .confirmationDialog(
                "Select Source",
                isPresented: $pekoConfigurations.showImagePickerActionSheet
            ) {
                Button("Camera") {
                    self.pekoConfigurations.selectedSourceCamera = .camera
                    self.showPicker = true
                }
                
                Button("Gallery") {
                    self.pekoConfigurations.selectedSourceCamera = .photoLibrary
                    self.showPicker = true
                }
            }
            .onReceive(PekoConfigurations.shared.$showImagePicker.dropFirst()) { showImagePicker in
                self.showPicker = showImagePicker
            }
    }
}

@available(iOS 16.4, *)
public struct ImagePickerSwiftUI: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    var allowsEditing: Bool
    var key: UIImagePickerController.InfoKey
    var croppingToSquare: Bool = false

    public init(
        selectedImage: Binding<UIImage?>,
        sourceType: UIImagePickerController.SourceType,
        allowsEditing: Bool,
        key: UIImagePickerController.InfoKey = .originalImage,
        croppingToSquare: Bool = false
    ) {
        self._selectedImage = selectedImage
        self.sourceType = sourceType
        self.allowsEditing = allowsEditing
        self.key = key
        self.croppingToSquare = croppingToSquare
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = allowsEditing
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerSwiftUI
        
        init(_ parent: ImagePickerSwiftUI) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if parent.allowsEditing {
                if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    parent.selectedImage = image
                }
            } else {
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    parent.selectedImage = parent.croppingToSquare ? image.croppingToSquare() : image
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

public extension UIImage {
    func croppingToSquare() -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        let resizeSize = min(cgImage.width, cgImage.height)
        return cropping(
            to: .init(
                x: (cgImage.width - resizeSize) / 2,
                y: (cgImage.height - resizeSize) / 2,
                width: resizeSize,
                height: resizeSize
            )
        )
    }

    func cropping(to rect: CGRect) -> UIImage? {
        let croppingRect: CGRect = imageOrientation.isLandscape ? rect.switched : rect
        guard let cgImage: CGImage = self.cgImage?.cropping(to: croppingRect) else { return nil }
        let cropped: UIImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        return cropped
    }
}

extension CGRect {
    var switched: CGRect {
        return CGRect(x: minY, y: minX, width: height, height: width)
    }
}

extension UIImage.Orientation {
    var isLandscape: Bool {
        switch self {
        case .up, .down, .upMirrored, .downMirrored:
            return false
        case .left, .right, .leftMirrored, .rightMirrored:
            return true
        @unknown default:
            fatalError()
        }
    }
}
