//
//  KeyCell.swift
//  pincode
//
//  Created by Нюргун on 21.09.2024.
//

import UIKit

class KeyCell: UICollectionViewCell {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        button.layer.cornerRadius = 35
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 70),
            button.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
