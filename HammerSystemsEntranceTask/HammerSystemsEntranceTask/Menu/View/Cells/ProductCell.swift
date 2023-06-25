//
//  ProductCell.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 22.06.2023.
//

import UIKit
import Kingfisher

// MARK: - ProductCell
final class ProductCell: UICollectionViewCell {
    static let reuseIdentifier: String = "ProductCellReuseIdentifier"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(named: "SecondaryFontColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var buyButton = BuyButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(buyButton)
        setConstraints()
    }
    
    private func setConstraints() {
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
        
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            buyButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(recipe: Recipe) {
        titleLabel.text = recipe.title
        
        descriptionLabel.text = recipe.sourceName
        
        buyButton.setPrice(Int(recipe.pricePerServing) * 70)
        
        guard let imageUrlString = recipe.image else {
            productImageView.image = UIImage(systemName: "photo.circle.fill")
            productImageView.tintColor = UIColor(named: "PinkColor")
            return
        }
        let url = URL(string: imageUrlString)
        productImageView.kf.setImage(with: url)
    }
}
