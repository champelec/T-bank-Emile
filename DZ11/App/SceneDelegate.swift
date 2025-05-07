//
//  SceneDelegate.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = DIAssembly.createImageDownloaderModule()
        self.window = window
        window.makeKeyAndVisible()
    }
}
