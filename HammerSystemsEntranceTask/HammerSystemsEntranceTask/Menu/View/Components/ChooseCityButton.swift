//
//  ChooseCityButton.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import UIKit

// MARK: - ChooseCityButton
final class ChooseCityButton: UIButton {
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Москва"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(cityLabel)
        addSubview(chevronImageView)
        setConstraints()
    }
    
    @objc private func buttonTapped() {
            print("Кнопка выбора города нажата")
        }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 5),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
