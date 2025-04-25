//
//  NetworkService.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
import Foundation

final class NetworkService {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        // Искусственная задержка 2 секунды для тестирования
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            guard let url = URL(string: "https://fakestoreapi.com/products") else {
                completion(.failure(.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }.resume()
        }
    }
}
