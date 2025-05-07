//
//  ImageCachesService.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
import UIKit

final class ImageCacheService {
    static let shared = ImageCacheService()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
