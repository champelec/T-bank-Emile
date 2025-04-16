//
//  SceneDelegate.swift
//  Emile HW8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let networkService = NetworkService()
        let presenter = ImageLoaderPresenter(networkService: networkService)
        let viewController = ImageLoaderViewController(presenter: presenter)
        presenter.view = viewController
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
    }
}
