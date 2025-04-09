import UIKit

struct DataSource {
    let model: String
    let description: String
    let price: String
    let imageName: String
    let oldPrice: String?
}

let data: [DataSource] = [
    DataSource(model: "IPhone 15", description: "IPhone 15 128GB 2023 синий", price: "59900 ₽", imageName: "iphone15w.png", oldPrice: "63990₽"),
    DataSource(model: "IPhone 15 Plus", description: "IPhone 15 Plus 256GB 2023 розовый", price: "76990 ₽", imageName: "iphone15plusw.png", oldPrice: "87990 ₽"),
    DataSource(model: "IPhone 16", description: "IPhone 16 128GB 2024 чёрный", price: "67990 ₽", imageName: "iphone16w.png", oldPrice: "81990 ₽"),
    DataSource(model: "IPhone 16 Plus", description: "IPhone 16 Plus 256GB 2024 ультрамарин", price: "76990 ₽", imageName: "iphone16plusw.png", oldPrice: "99900 ₽"),
    DataSource(model: "IPhone 16 Pro Max", description: "IPhone 16 Pro Max 1TB 2024 пустынный титан", price: "135990 ₽", imageName: "iphone16promaxw.png", oldPrice: "139990 ₽")
]

class ViewController: UIViewController {
    var currentIndex: Int = 0
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать следующий товар", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = data[0].description
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel1 = UILabel()
        nameLabel1.text = data[0].model
        nameLabel1.textColor = .gray
        nameLabel1.font = .systemFont(ofSize: 18)
        nameLabel1.textAlignment = .center
        nameLabel1.numberOfLines = 1
        nameLabel1.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel1
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel1 = UILabel()
        priceLabel1.text = data[0].price
        priceLabel1.textColor = .white
        priceLabel1.font = .systemFont(ofSize: 26, weight: .bold)
        priceLabel1.textAlignment = .center
        priceLabel1.numberOfLines = 1
        priceLabel1.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel1
    }()
    
    private let oldPriceLabel: UILabel = {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: data[0].oldPrice!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        let oldPrice1 =  UILabel()
        oldPrice1.attributedText = attributeString
        oldPrice1.textColor = .gray
        oldPrice1.font = .systemFont(ofSize: 22, weight: .bold)
        oldPrice1.textAlignment = .center
        oldPrice1.numberOfLines = 1
        oldPrice1.translatesAutoresizingMaskIntoConstraints = false
        return oldPrice1
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: data[0].imageName)
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return  image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .black
        mainButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(mainButton)
        view.addSubview(imageView)
        view.addSubview(oldPriceLabel)
        view.addSubview(mainLabel)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)

        setupConstraints()
    }
 
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            
            oldPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16),
            oldPriceLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func didTapButton() {
        currentIndex = (currentIndex + 1) % data.count
        nameLabel.text = data[currentIndex].model
        mainLabel.text = data[currentIndex].description
        priceLabel.text = data[currentIndex].price
        oldPriceLabel.text = data [currentIndex].oldPrice
        imageView.image = UIImage(named: data[currentIndex].imageName)
    }
}

