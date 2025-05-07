//
//  DIAssembly.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
import UIKit

final class DIAssembly {
    
    // MARK: - Services
    static func makeAPIClient() -> APIClient {
        return APIClient.shared
    }
    
    static func makeImageCacheService() -> ImageCacheService {
        return ImageCacheService.shared
    }
    
    // MARK: - Repositories
    static func makeRemoteImageRepository() -> ImageRepositoryProtocol {
        return RemoteImageRepository(
            apiClient: makeAPIClient(),
            cacheService: makeImageCacheService()
        )
    }
    
    static func makeMockImageRepository() -> ImageRepositoryProtocol {
        return MockImageRepository()
    }
    
    // MARK: - Modules
    static func createImageDownloaderModule() -> UIViewController {
        let viewController = ViewController()
        let repository = makeRemoteImageRepository()
        let presenter = Presenter(
            view: viewController,
            repository: repository
        )
        viewController.presenter = presenter
        return viewController
    }
}
