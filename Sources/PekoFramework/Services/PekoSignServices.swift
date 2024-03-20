//
//  PekoSignServices.swift
//
//
//  Created by Lukáš Spurný on 20.03.2024.
//

import Foundation
import AuthenticationServices
import Combine

@available(iOS 16.4, *)
public class PekoSignServices: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    
    public enum TypeSignButton: CaseIterable {
        case email
        case apple
        case facebook
        case google
        case anonymous
    }
    
    public enum SignError: Error {
        case custom(String)
        case error(Error)
    }
    
    public static var shared = PekoSignServices()
    
    @Published public var appleCredential: ASAuthorizationAppleIDCredential? = nil
    
    //public init() {}
    
    public func login(type: TypeSignButton) {
        switch type {
        case .apple:
            performAppleSignIn()
        default: break
        }
    }
    
    // MARK: - Apple
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ){
        if let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            self.appleCredential = appleCredential
        } else {
            PekoConfigurations.shared.showToast = Toast(style: .error, message: "User credentials is not valid")
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if error.errorCode == 1001 {
            PekoConfigurations.shared.showToast = Toast(style: .error, message: "User cancel")
        } else {
            PekoConfigurations.shared.showToast = Toast(style: .error, message: error.localizedDescription)
        }
    }
    
    func performAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}
