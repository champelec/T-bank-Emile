//
//  ImageLoaderService.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 25.04.2025.
//
import UIKit

protocol ImageLoaderServiceProtocol {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}

final class ImageLoaderService: ImageLoaderServiceProtocol {
    private let imageCache: ImageCache
    
    init(imageCache: ImageCache) {
        self.imageCache = imageCache
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.image(for: urlString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self?.imageCache.save(image, for: urlString)
            completion(image)
        }.resume()
    }
}
