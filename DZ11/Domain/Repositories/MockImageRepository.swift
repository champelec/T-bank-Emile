//
//  MockImageRepository.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
final class MockImageRepository: ImageRepositoryProtocol {
    func fetchImages(urls: [String], completion: @escaping ([ImageEntity]) -> Void) {
        let images = urls.map { url in
            ImageEntity(url: url, image: UIImage(named: "mock_image"))
        }
        completion(images)
    }
}
