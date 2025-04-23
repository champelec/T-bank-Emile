import Alamofire
import UIKit

class ViewController: UIViewController {
    private let imageDownloader: ViewInput = ImageDownloader()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Загрузить изображения", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return  image
    }()
    
    private let imageView2: UIImageView = {
        let image2 = UIImageView()
        image2.contentMode = .scaleAspectFit
        image2.clipsToBounds = true
        image2.translatesAutoresizingMaskIntoConstraints = false
        return  image2
    }()
    
    private let imageView3: UIImageView = {
        let image3 = UIImageView()
        image3.contentMode = .scaleAspectFit
        image3.clipsToBounds = true
        image3.translatesAutoresizingMaskIntoConstraints = false
        return  image3
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .white
        mainButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(mainButton)
        view.addSubview(imageView)
        view.addSubview(imageView2)
        view.addSubview(imageView3)

        view.addSubview(activityIndicator)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainButton.heightAnchor.constraint(equalToConstant: 48),
            
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            imageView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView2.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            imageView2.heightAnchor.constraint(equalToConstant: 200),
            
            imageView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView3.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 16),
            imageView3.heightAnchor.constraint(equalToConstant: 200),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapButton() {
        activityIndicator.startAnimating()
        
        imageDownloader.downloadImages() { [weak self] images in
            guard let self = self else { return }
            imageView.image = images[0]
            imageView2.image = images[1]
            imageView3.image = images[2]
            activityIndicator.stopAnimating()
        }
    }
}
