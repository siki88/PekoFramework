PekoFramework

## Setting:

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PekoConfigurations.shared)
                .pekoFrameworkView()
        }
    }
    
    Implement NEW NewtorkService to project
    

## Toast:
    NewtorkService: When an error, show error toast

    Manually Show:
        PekoConfigurations.shared.showToast = Toast(style: .success, message: " ")
    
## Activity Indicator:
    NewtorkService: Default setting enable start and stop activity indicator

    Manually Show:
        PekoConfigurations.shared.showActivityIndicator = true/false

## SharedActivityView:
    Manually Show:
        PekoConfigurations.shared.itemsSharedActivityView = Array(Any)
        PekoConfigurations.shared.showSharedActivityView = true/false

## ImagePicker: Camera + Image Gallery(select single image)
    Setting / Implement plist:
        Privacy - Camera Usage Description -> Aplikace žádá o přístup k fotoaparátu
        
    Setting:    
        PekoConfigurations.shared.selectedSourceCamera = .camera/photoLybrary  
         
    Manually Show:    
        PekoConfigurations.shared.showImagePickerActionSheet = true/false
        PekoConfigurations.shared.showImagePicker = true/false

    Callback: onReceive OR combine
        .onReceive(PekoConfigurations.shared.$selectedImage.dropFirst()) { selectedImage in
            print("👍 selectedImage: ",selectedImage)
        }
        
## PHPickerView: Image Gallery(select more image)
    Setting:    
        PekoConfigurations.shared.selectionLimitPHPicker = Int
      
    Manually Show:
        PekoConfigurations.shared.showPHPicker = true/false
        
    Callback: onReceive OR combine
        .onReceive(PekoConfigurations.shared.$selectedImages.dropFirst()) { selectedImages in
            print("👍 selectedImages: ",selectedImages)
        }

TUDU:
SharedActivityView: impl onDismiss action ?
ImagePicker: impl onDismiss action ?
PHPicker: impl onDismiss action ?

Impl: Apple login ?
Impl: Google login ?
Impl: Facebook login ?
