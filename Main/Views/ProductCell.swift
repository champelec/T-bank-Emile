//
//  ProductCell.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
import UIKit

final class ProductCell: UITableViewCell {
    static let reuseIdentifier = "ProductCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private var currentImageURL: String?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        currentImageURL = nil
    }
    
    // MARK: - Configuration
    func configure(with product: Product) {
        titleLabel.text = product.title
        loadImage(from: product.image)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [productImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func loadImage(from urlString: String) {
        currentImageURL = urlString
        
        if let cachedImage = ImageCache.shared.image(for: urlString) {
            productImageView.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            ImageCache.shared.save(image, for: urlString)
            
            DispatchQueue.main.async {
                if self.currentImageURL == urlString {
                    self.productImageView.image = image
                }
            }
        }.resume()
    }
}
