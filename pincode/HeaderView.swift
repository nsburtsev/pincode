//
//  HeaderView.swift
//  pincode
//
//  Created by Нюргун on 21.09.2024.
//

import UIKit

class HeaderView: UIView {
    
    private let closeButton = UIButton(type: .custom)
    private let stackView = UIStackView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private var pinIndicators = [UIView]()
    var enteredPin = "" {
        didSet {
            updatePinIndicators()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //backgroundColor = .yellow
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.backgroundColor = .none
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        //stackView.backgroundColor = .green
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "Код быстрого доступа"
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        
        subtitle.text = "Придумайте код для быстрого доступа к приложению"
        subtitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitle.textAlignment = .center
        subtitle.numberOfLines = 0
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        let pinStackView = UIStackView()
        //pinStackView.backgroundColor = .yellow
        pinStackView.axis = .horizontal
        pinStackView.spacing = 36
        pinStackView.alignment = .center
        pinStackView.distribution = .fillEqually
        pinStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<4 {
            let indicator = createPinIndicator()
            pinIndicators.append(indicator)
            pinStackView.addArrangedSubview(indicator)
        }
        
        addSubview(closeButton)
        addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        addSubview(pinStackView)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 90),
            
            pinStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pinStackView.heightAnchor.constraint(equalToConstant: 40),
            pinStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
    
    private func createPinIndicator() -> UIView {
        let indicator = UIView()
        indicator.backgroundColor = UIColor(white: 0.9, alpha: 1)
        indicator.layer.cornerRadius = 10
        indicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return indicator
    }
    
    private func updatePinIndicators() {
        for (index, indicator) in pinIndicators.enumerated() {
            if index < enteredPin.count {
                indicator.backgroundColor = UIColor(named: "blue")
                let externalBorder = CALayer()
                externalBorder.borderColor = UIColor(named: "ocean")?.cgColor
                externalBorder.borderWidth = 8
                let borderInset: CGFloat = -7
                externalBorder.frame = indicator.bounds.insetBy(dx: borderInset, dy: borderInset)
                externalBorder.cornerRadius = 17
                indicator.layer.addSublayer(externalBorder)
            } else {
                indicator.backgroundColor = UIColor(white: 0.9, alpha: 1)
                indicator.layer.sublayers?.forEach { layer in
                    if layer is CALayer {
                        layer.removeFromSuperlayer()
                    }
                }
            }
        }
    }
    
    func addPinDigit(_ digit: String) {
        if enteredPin.count < 4 {
            enteredPin += digit
        }
    }
    
    func removePinDigit() {
        if !enteredPin.isEmpty {
            enteredPin.removeLast()
        }
    }
    
    func resetPin() {
        enteredPin = ""
    }
    
    func updateSubtitle(_ text: String) {
        subtitle.text = text
    }
}
