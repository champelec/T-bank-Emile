//
//  SceneDelegate.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let assembly = Assembly() // Используем Assembly
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = assembly.makeImageLoaderViewController()
        window?.makeKeyAndVisible()
    }
}
