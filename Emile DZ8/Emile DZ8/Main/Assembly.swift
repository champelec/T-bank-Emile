//
//  Assembly.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 25.04.2025.
//
import UIKit

final class Assembly {
    
    lazy var imageCache: ImageCache = ImageCache()
    
    lazy var imageLoaderService: ImageLoaderServiceProtocol = {
        ImageLoaderService(imageCache: imageCache)
    }()
    
    lazy var networkService: NetworkService = NetworkService()
    
    func makeImageLoaderViewController() -> UIViewController {
        let presenter = ImageLoaderPresenter(networkService: networkService)
        let viewController = ImageLoaderViewController(presenter: presenter)
        presenter.view = viewController
        return UINavigationController(rootViewController: viewController)
    }
}
