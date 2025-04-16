//
//  ImageCache.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?
    
    private init() {
        // Очищаем кэш при получении уведомления о нехватке памяти
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func removeImage(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
