//
//  PHPicker.swift
//
//
//  Created by Lukáš Spurný on 19.03.2024.
//

import SwiftUI
import PhotosUI

@available(iOS 16.4, *)
public extension View {
    func pHPickerModifier() -> some View {
        self.modifier(PHPickerModifier())
    }
}

@available(iOS 16.4, *)
struct PHPickerModifier: ViewModifier {
    
    @EnvironmentObject private var pekoConfigurations: PekoConfigurations
    
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: $pekoConfigurations.showPHPicker,
                onDismiss: {
                    print("TUDU: dismiss PHPickerView")
                }, content: {
                    PHPickerView(
                        selectionLimit: pekoConfigurations.selectionLimitPHPicker,
                        images: $pekoConfigurations.selectedImages
                    )
                        .edgesIgnoringSafeArea(.all)
                })
    }
}

@available(iOS 16.4, *)
public struct PHPickerView: UIViewControllerRepresentable {
    
    @State var selectionLimit: Int = 1
    @Binding var images: [UIImage]?
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PHPickerView
        
        init(_ parent: PHPickerView) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            let imageItems = results
                .map { $0.itemProvider }
                .filter { $0.canLoadObject(ofClass: UIImage.self) }
            
            let dispatchGroup = DispatchGroup()
            var images = [UIImage]()
            
            for imageItem in imageItems {
                dispatchGroup.enter()
                
                imageItem.loadObject(ofClass: UIImage.self) { image, _ in
                    if let image = image as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.parent.images = images
                picker.dismiss(animated: true)
            }
        }
    }
}
