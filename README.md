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
    Manually Show/Hide:
        PekoConfigurations.shared.itemsSharedActivityView = Array(Any)
        PekoConfigurations.shared.showSharedActivityView = true/false

## ImagePicker: Camera + Image Gallery(select single image)
    Setting / Implement plist:
        Privacy - Camera Usage Description -> Aplikace žádá o přístup k fotoaparátu
        
    Setting:    
        PekoConfigurations.shared.selectedSourceCamera = .camera/photoLybrary  
         
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

## TUDU:

SharedActivityView: impl onDismiss action ?
ImagePicker: impl onDismiss action ?
PHPicker: impl onDismiss action ?

Impl: Apple login ?
Impl: Google login ?
Impl: Facebook login ?
