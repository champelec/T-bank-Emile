//
//  AnimatedViewController.swift
//  Animations-Example
//
//  Created by Эмиль Шамшетдинов on 30.04.2025.
//

import UIKit

final class AnimatedViewController: UIViewController {
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "banknote.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(translationX: 0, y: -200)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Т-Банк"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .darkText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5).rotated(by: -.pi/8)
        
        button.layer.shadowColor = UIColor.systemBlue.cgColor
        button.layer.shadowOpacity = 0
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 10
        
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateElements()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func animateElements() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0.2,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: {
                self.logoImageView.alpha = 1
                self.logoImageView.transform = .identity
            }
        )
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0.4,
            options: .curveEaseIn,
            animations: {
                self.titleLabel.alpha = 1
            }
        )
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0.6,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.7,
            options: .curveEaseOut,
            animations: {
                self.actionButton.alpha = 1
                self.actionButton.transform = .identity
            },
            completion: { _ in
                self.animateButtonShadow()
            }
        )
    }
    
    private func animateButtonShadow() {
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fromValue = 0
        shadowAnimation.toValue = 0.3
        shadowAnimation.duration = 0.5
        shadowAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        actionButton.layer.shadowOpacity = 0.3
        CATransaction.commit()
        
        actionButton.layer.add(shadowAnimation, forKey: "shadowAnimation")
    }
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: 0.2) {
            self.actionButton.layer.cornerRadius = 25
            self.actionButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func buttonTouchUp() {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.3,
            options: .curveEaseOut,
            animations: {
                self.actionButton.layer.cornerRadius = 12
                self.actionButton.transform = .identity
            }
        )
    }
}
