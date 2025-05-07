//
//  RemoteImageRepository.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
final class RemoteImageRepository: ImageRepositoryProtocol {
    private let apiClient: APIClient
    private let cacheService: ImageCacheService
    
    init(apiClient: APIClient = .shared,
         cacheService: ImageCacheService = .shared) {
        self.apiClient = apiClient
        self.cacheService = cacheService
    }
    
    func fetchImages(urls: [String], completion: @escaping ([ImageEntity]) -> Void) {
        var images: [ImageEntity] = []
        let group = DispatchGroup()
        
        for url in urls {
            group.enter()
            
            if let cachedImage = cacheService.image(for: url) {
                images.append(ImageEntity(url: url, image: cachedImage))
                group.leave()
                continue
            }
            
            apiClient.request(url) { [weak self] result in
                defer { group.leave() }
                
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    if let image = image {
                        self?.cacheService.save(image: image, for: url)
                    }
                    images.append(ImageEntity(url: url, image: image))
                case .failure:
                    images.append(ImageEntity(url: url, image: nil))
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(images)
        }
    }
}
