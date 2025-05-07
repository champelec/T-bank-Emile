//
//  ViewController.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
final class ViewController: UIViewController {
    private var presenter: ImageDownloaderPresenterProtocol!
    private var imageViews: [UIImageView] = []
    
    // UI components setup as before...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDependencies()
        presenter.viewDidLoad()
    }
    
    private func setupDependencies() {
        // Для реального использования
        presenter = ImageDownloaderPresenter(view: self)
        
        // Для тестов/превью можно использовать мок:
        // presenter = ImageDownloaderPresenter(view: self, repository: MockImageRepository())
    }
    
    @objc private func didTapButton() {
        presenter.didTapDownloadButton()
    }
}

extension ViewController: ImageDownloaderViewProtocol {
    func displayImages(_ images: [UIImage]) {
        for (index, image) in images.enumerated() {
            if index < imageViews.count {
                imageViews[index].image = image
            }
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
