//
//  CategoryCell.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 23.06.2023.
//

import UIKit

// MARK: - CategoryCell
final class CategoryCell: UICollectionViewCell {
    static let reuseIdentifier: String = "CategoryCellReuseIdentifier"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "PinkColor")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
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
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "PinkColor")?.cgColor
        contentView.layer.cornerRadius = 20
        contentView.addSubview(titleLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(categoryTitle: String?) {
        titleLabel.text = categoryTitle
    }
    
    func didSelect() {
        contentView.backgroundColor = UIColor(named: "PinkColor")
        titleLabel.textColor = UIColor(named: "PurpleColor")
    }
    
    func didDeselect() {
        contentView.backgroundColor = .white
        titleLabel.textColor = UIColor(named: "PinkColor")
    }
}
