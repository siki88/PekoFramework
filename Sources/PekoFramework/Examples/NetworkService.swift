//
//  File.swift
//  
//
//  Created by Lukáš Spurný on 19.03.2024.
//

/*
#warning("TEMPLATE NETWORKING FOR IMPLEMENT PROJECT")

import Foundation.NSNotificationQueue
import Alamofire
import Combine
import PekoFramework

class NetworkService: ObservableObject {
    
    private static var cancellables: Set<AnyCancellable> = []
    
    static func universalFetchData<T: Decodable>(_ type :T.Type, apiRouter: APIRouter) async throws -> T {
        try await AF.request(apiRouter)
            .serializingDecodable(T.self).value
    }
    
    static func universalSortFetchDataCombine<T: Decodable>(
        _ type :T.Type,
        apiRouter: APIRouter,
        queue: DispatchQueue = .main
    ) -> AnyPublisher<T, AFError> {
        AF.request(apiRouter)
            .publishDecodable(type: T.self, queue: queue)
            .value()
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
    
    static func universalFetchDataCombine<T: Decodable>(
        _ type :T.Type,
        apiRouter: APIRouter,
        queue: DispatchQueue = .main,
        enableErrorToast: Bool = true,
        enableAI enableActivityIndicator: Bool = true
    ) -> AnyPublisher<T, AFError> {
        if enableActivityIndicator || enableErrorToast {
            let publisher = PassthroughSubject<T, AFError>()
            
            if enableActivityIndicator {
                PekoConfigurations.shared.showActivityIndicator = true
            }
            
            AF.request(apiRouter)
                .publishDecodable(type: T.self, queue: queue)
                .value()
                .receive(on: queue)
                .sink {
                    if enableActivityIndicator {
                        PekoConfigurations.shared.showActivityIndicator = false
                    }
                    if enableErrorToast {
                        switch $0 {
                        case .failure(let error):
                            print("📕 universalFetchDataCombine ERROR: apiRouter: \(apiRouter), Error.loc: ",error.localizedDescription)
                            PekoConfigurations.shared.showToast = Toast(style: .error, message: error.localizedDescription)
                            publisher.send(completion: .failure(error))
                        case .finished:
                            print("📗 universalFetchDataCombine FINISHED: apiRouter: \(apiRouter)")
                            publisher.send(completion: .finished)
                        }
                    } else {
                        publisher.send(completion: $0)
                    }
                } receiveValue: {
                    publisher.send($0)
                }
                .store(in: &cancellables)
            
            return publisher
                .receive(on: queue)
                .eraseToAnyPublisher()
        } else {
            return AF.request(apiRouter)
                .publishDecodable(type: T.self, queue: queue)
                .value()
                .receive(on: queue)
                .eraseToAnyPublisher()
        }
    }
    
    static func uploadImageCombine<T: Decodable>(
        _ type :T.Type,
        apiRouter: APIRouter,
        parameters: [String: Any],
        imageData: Data,
        setting: SettingUploadImageCombine? = nil,
        queue: DispatchQueue = .main
    ) -> AnyPublisher<T, AFError> {
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append(
                    (value as AnyObject).data(using: String.Encoding.utf8.rawValue)!,
                    withName: key
                )
            }
            if let setting {
                multipartFormData.append(
                    imageData,
                    withName: setting.withName,
                    fileName: setting.fileName,
                    mimeType: setting.mimeType
                )
            }
        }, to: apiRouter.requestURL, method: apiRouter.method, headers: apiRouter.headers)
        .publishDecodable(type: T.self, queue: queue)
        .value()
        .receive(on: queue)
        .eraseToAnyPublisher()
    }
}

struct SettingUploadImageCombine {
    var withName: String = "file"
    var fileName: String = "file.jpeg"
    var mimeType: String = "image/jpeg"
}
*/
