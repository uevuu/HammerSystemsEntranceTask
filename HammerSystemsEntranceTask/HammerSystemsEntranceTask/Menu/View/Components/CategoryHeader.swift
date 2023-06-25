//
//  CategoryHeader.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import UIKit

// MARK: - CategoryHeaderDelegate
protocol CategoryHeaderDelegate: AnyObject {
    func getCategoryCount() -> Int
    func getCategoryName(at position: IndexPath) -> String
    func tapAtCategory(at position: IndexPath)
}

// MARK: - CategoryHeader
final class CategoryHeader: UICollectionReusableView {
    static let reuseIdentifier: String = "CategoryHeaderReuseIdentifier"
    weak var delegate: CategoryHeaderDelegate?
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.reuseIdentifier
        )
        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let sections: [Section] = [CategorySection()]
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func setupView() {
        addSubview(collectionView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
    }
    
    func scrollTo(_ position: IndexPath) {
        collectionView.indexPathsForSelectedItems?.forEach({ indexPath in
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.didDeselect()
            }
        })
        collectionView.selectItem(
            at: position,
            animated: true,
            scrollPosition: .left
        )
        if let cell = collectionView.cellForItem(at: position) as? CategoryCell {
            cell.didSelect()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CategoryHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.getCategoryCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.reuseIdentifier,
            for: indexPath
        ) as? CategoryCell else {
            fatalError("Error with getting CategoryCell")
        }
        let name = delegate?.getCategoryName(at: indexPath)
        cell.configureCell(categoryTitle: name)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryHeader: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.didSelect()
            collectionView.scrollToItem(
                at: indexPath,
                at: .left,
                animated: true
            )
            delegate?.tapAtCategory(at: indexPath)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.didDeselect()
        }
    }
}
