//
//  ImageLoaderPresenter.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
import UIKit

protocol ImageLoaderPresenterProtocol: AnyObject {
    var numberOfProducts: Int { get }
    var progressText: String { get }
    func viewDidLoad()
    func product(at index: Int) -> Product
}

final class ImageLoaderPresenter {
    weak var view: ImageLoaderViewProtocol?
    private let networkService: NetworkService
    
    private var products: [Product] = []
    private var downloadProgress: [Int: Float] = [:]
    private var totalDownloaded: Int = 0
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private func loadProducts() {
            print("Показываем индикатор")
            view?.showLoadingIndicator(true)
            
            networkService.fetchProducts { [weak self] result in
                print("Скрываем индикатор")
                DispatchQueue.main.async {
                    self?.view?.showLoadingIndicator(false)
                    
                    switch result {
                    case .success(let products):
                        self?.products = products
                        self?.startImageDownload()
                        self?.view?.reloadData()
                    case .failure(let error):
                        self?.view?.showError(message: error.localizedDescription)
                    }
                }
            }
        }
    
    private func startImageDownload() {
        downloadProgress.removeAll()
        totalDownloaded = 0
        
        for (index, product) in products.enumerated() {
            downloadImage(from: product.image, for: index)
        }
    }
    
    private func downloadImage(from urlString: String, for index: Int) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let _ = error {
                DispatchQueue.main.async {
                    self.downloadProgress[index] = 0
                    self.updateProgress()
                }
                return
            }
            
            if let data = data, let _ = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.downloadProgress[index] = 1.0
                    self.totalDownloaded += 1
                    self.updateProgress()
                    self.view?.reloadRow(at: index)
                }
            }
        }
        
        task.resume()
    }
    
    private func updateProgress() {
        let totalProgress = downloadProgress.values.reduce(0, +) / Float(products.count)
        view?.updateProgress(totalProgress)
    }
}

extension ImageLoaderPresenter: ImageLoaderPresenterProtocol {
    var numberOfProducts: Int { products.count }

    var progressText: String {
        let percentage = Int((downloadProgress.values.reduce(0, +) / Float(products.count) * 100))
        return "Загружено \(totalDownloaded) из \(products.count) (Прогресс: \(percentage)%)"
    }
    
    func viewDidLoad() {
        loadProducts()
    }
    
    func product(at index: Int) -> Product {
        products[index]
    }
}
