//
//  ViewController.swift
//  pincode
//
//  Created by Нюргун on 20.09.2024.
//

import UIKit

class ViewController: UIViewController  {
    
    fileprivate let cellId = "cellId"
    
    let numbers = ["1","2","3","4","5","6","7","8","9", "", "0", "←"]
    
    private let headerView = HeaderView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let forgotButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        //collectionView.backgroundColor = .green
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        forgotButton.setTitle("Я забыл ПИН-код", for: .normal)
        forgotButton.setTitleColor(UIColor(named: "blue"), for: .normal)
        forgotButton.setTitleColor(.gray, for: .highlighted)
        forgotButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
        view.addSubview(forgotButton)
        
        let safeArea = view.safeAreaLayoutGuide
        let height = view.frame.height * 0.36
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: height),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: forgotButton.topAnchor),
            
            forgotButton.heightAnchor.constraint(equalToConstant: 30),
            forgotButton.widthAnchor.constraint(equalToConstant: 170),
            forgotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -5),
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! KeyCell
        cell.button.setTitle(numbers[indexPath.item], for: .normal)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNumber = numbers[indexPath.item]
        if selectedNumber == "←" {
            headerView.removePinDigit()
        } else if selectedNumber != "" {
            headerView.addPinDigit(selectedNumber)
            
            if headerView.enteredPin.count == 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.headerView.updateSubtitle("Повторите придуманный пин")
                    self?.headerView.resetPin()
                    self?.forgotButton.isHidden = true
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeyCell {
            cell.button.backgroundColor = UIColor(named: "ocean") // Цвет кнопки при нажатии
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeyCell {
            cell.button.backgroundColor = .systemBackground // Цвет кнопки после нажатия
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPadding = view.frame.width * 0.13
        let interSpacing = view.frame.width * 0.1
        let cellWidth = (view.frame.width - 2 * leftRightPadding - 2 * interSpacing) / 3
        return .init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightPadding = view.frame.width * 0.13
        return .init(top: view.frame.height * 0.03,
                     left: leftRightPadding,
                     bottom: 0,
                     right: leftRightPadding)
    }
}
