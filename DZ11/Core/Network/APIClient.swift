//
//  APIClient.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
import Alamofire

protocol APIClientProtocol {
    func request(_ url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private init() {}
    
    func request(_ url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
