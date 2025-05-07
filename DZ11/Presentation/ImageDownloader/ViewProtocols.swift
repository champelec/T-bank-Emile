//
//  ViewProtocols.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
protocol ImageDownloaderViewProtocol: AnyObject {
    func displayImages(_ images: [UIImage])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}

protocol ImageDownloaderPresenterProtocol {
    func viewDidLoad()
    func didTapDownloadButton()
}
