//
//  Presenter.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//

import UIKit
import Alamofire

final class ImageDownloaderPresenter {
    private weak var view: ImageDownloaderViewProtocol?
    private let repository: ImageRepositoryProtocol
    
    init(view: ImageDownloaderViewProtocol,
         repository: ImageRepositoryProtocol = RemoteImageRepository()) {
        self.view = view
        self.repository = repository
    }
}

extension ImageDownloaderPresenter: ImageDownloaderPresenterProtocol {
    func viewDidLoad() {
        // Initial setup if needed
    }
    
    func didTapDownloadButton() {
        view?.showLoading(true)
        
        let urls = [
            "https://www.alleycat.org/wp-content/uploads/2016/06/Day-32-Denby.jpg",
            "https://i.bigenc.ru/resizer/resize?sign=ZsmpjGkl2ga8dDG74SLngQ&filename=vault/0995c4be88c50ceb10096ba695c2c03b.webp&width=1024",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6PrxMYTq5vrDjYPYr5mb1FY_1pAWmcQkssA&s"
        ]
        
        repository.fetchImages(urls: urls) { [weak self] entities in
            self?.view?.showLoading(false)
            let images = entities.map { $0.image ?? $0.placeholder }
            self?.view?.displayImages(images)
        }
    }
}
