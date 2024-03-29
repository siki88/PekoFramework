PekoFramework

## Setting:

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PekoConfigurations.shared)
                .pekoFrameworkView()
        }
    }
    
    Implement NEW NewtorkService to project !!!

## Wormholy:
    iOS network debugging
    Enable for only DEBUG mode
    Use: Zatřesením

## Toast:
    NewtorkService: When an error, show error toast

    Manually Show:
        PekoConfigurations.shared.showToast = Toast(style: .success, message: " ")
    
## Activity Indicator:
    NewtorkService: Default setting enable start and stop activity indicator

    Manually Show/Hide:
        PekoConfigurations.shared.showActivityIndicator = true/false

## SharedActivityView:
    Setting:
    -- for manual array
        PekoConfigurations.shared.itemsSharedActivityView = Array(Any)
    -- object for special image and text
        PekoConfigurations.shared.shareableImageSharedActivityView

    Manually Show/Hide:
        PekoConfigurations.shared.showSharedActivityView = true/false

## ImagePicker: Camera + Image Gallery(select single image)
    Implement plist:
        Privacy - Camera Usage Description -> Aplikace žádá o přístup k fotoaparátu
        
    Setting:    
        PekoConfigurations.shared.selectedSourceCamera = .camera/photoLibrary  
         
    Manually Show/Hide: 
        ActionSheet PopUp for selected:
            PekoConfigurations.shared.showImagePickerActionSheet = true/false
        Open selectedSourceCamera type:
            PekoConfigurations.shared.showImagePicker = true/false

    Callback: onReceive OR Combine
        .onReceive(PekoConfigurations.shared.$selectedImage.dropFirst()) { selectedImage in
            print("👍 selectedImage: ",selectedImage)
        }
        
        PekoConfigurations.shared.$selectedImage
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { weak self selectedImage in
                guard let _ = self else { return }
                print("👍 selectedImage: ",selectedImage)
            }
            .store(in: &cancellables)
        
## PHPickerView: Image Gallery(select more image)
    Setting:    
        PekoConfigurations.shared.selectionLimitPHPicker = Int
      
    Manually Show:
        PekoConfigurations.shared.showPHPicker = true/false
        
    Callback: onReceive OR Combine
        .onReceive(PekoConfigurations.shared.$selectedImages.dropFirst()) { selectedImages in
            print("👍 selectedImages: ",selectedImages)
        }
        
        PekoConfigurations.shared.$selectedImages
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { weak self selectedImages in
                guard let _ = self else { return }
                print("👍 selectedImages: ",selectedImages)
            }
            .store(in: &cancellables)

## Tools/Utility:
    - PekoCustomContent
    - PekoNavigationContent
    - PekoCustomNavigationContent
    
    - CustomGridLayout: Alternative LazyVGrid column, not lazy
        CustomGridLayout(array, numberOfColumns: 3) { result in
    
    - WrappingHStack: WrappingHStack is a UI Element that works in a very similar way to HStack, but automatically positions overflowing elements on next lines.
    
    - ActivityIndicatorView: ActivityIndicatorView(isVisible: Binding Bool, color: Color, type: IndicatorType)
    
    - DeviceRotation: 
            .detectOrientation($orientation)
            .onRotate { newOrientation in }
            
    - RoundedCorner: 
            .cornerRadius(40, corners: [.topLeft, .topRight])
    
    - PekoBottomSheetView: rozdelane
    
    - SafeAreaInsets:
        @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    - KeyboardHeightHelper:
        @ObservedObject private var keyboardHeightHelper = KeyboardHeightHelper()
        
    - ReflectedStringConvertible: logger printer:
        class GamepanelResume: Codable, ReflectedStringConvertible {

    - ExpandableText: Read more AND Read less long text
        ExpandableText("TUDU",lineLimit: 3,font: UIFont.systemFont(ofSize: 15))
    
    - ImagePinchZoomView: image zoom
        image
            .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
            
## Sign:

    ### Apple:
        Manually Show:
            PekoSignServices.shared.login(type: .apple)
        Response:
            PekoSignServices.shared.$appleCredential
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { weak self appleCredential in
                guard let self = self, let appleCredential else { return }
                let token = appleCredential.identityToken
                print("🚀 appleCredential.identityToken: ",token)
                print("🚀 appleCredential.identityToken base: ",token?.base64EncodedString())
                if let token {
                    print("🚀 appleCredential.identityToken encoding: ",String(data: token, encoding: .utf8))
                }
                print("🚀 appleCredential.email: ",appleCredential.email)
                print("🚀 appleCredential.fullName: ",appleCredential.fullName)
            }
            .store(in: &cancellables)
            
    ### Google:
    
    ### Facebook:
            
## TUDU:

SharedActivityView: impl onDismiss action ?
ImagePicker: impl onDismiss action ?
PHPicker: impl onDismiss action ?

Impl: Apple login ?
Impl: Google login ?
Impl: Facebook login ?
