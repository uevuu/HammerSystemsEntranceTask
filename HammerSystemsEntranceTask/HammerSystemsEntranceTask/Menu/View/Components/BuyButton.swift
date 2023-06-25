//
//  BuyButton.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import UIKit

// MARK: - BuyButton
final class BuyButton: UIButton {
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "PurpleColor")
        label.text = "от ... р"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(priceLabel)
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "PurpleColor")?.cgColor
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func setPrice(_ price: Int) {
        priceLabel.text = "от \(price) р"
    }
}

