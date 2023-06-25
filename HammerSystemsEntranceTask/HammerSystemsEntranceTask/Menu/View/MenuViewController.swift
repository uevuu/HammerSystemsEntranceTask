//
//  MenuViewController.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 22.06.2023.
//

import UIKit

// MARK: - MenuViewController
final class MenuViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let output: MenuViewOutput
    private weak var categoryHeader: CategoryHeader?
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            BannerCell.self,
            forCellWithReuseIdentifier: BannerCell.reuseIdentifier
        )
        collectionView.register(
            CategoryHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeader.reuseIdentifier
        )
        collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let sections: [Section] = [BannerSection(), ProductSection()]
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    
    // MARK: - Init
       init(output: MenuViewOutput) {
           self.output = output
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoadEvent()
        
        
        let chooseCityButton = ChooseCityButton()
        let customBarButtonItem = UIBarButtonItem(customView: chooseCityButton)
        navigationItem.leftBarButtonItem = customBarButtonItem
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MenuViewController: MenuViewInput {
    func reloadSections() {
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    func scrollTo(position: IndexPath) {
        collectionView.scrollToItem(at: position, at: .top, animated: true)
    }
    
    func scrollHeaderTo(_ position: IndexPath) {
        categoryHeader?.scrollTo(position)
    }
}

// MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.getNumberOfSections()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return output.getNumberOfItemsInSection(at: section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.reuseIdentifier,
                for: indexPath
            ) as? BannerCell else {
                fatalError("Error with getting BannerCell")
            }
            cell.configureCell(mockBannerImageName: "PizzaImageBanner")
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCell.reuseIdentifier,
                for: indexPath
            ) as? ProductCell else {
                fatalError("Error with getting ProductCell")
            }
            let recipe = output.getRecipe(at: indexPath)
            cell.configureCell(recipe: recipe)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CategoryHeader.reuseIdentifier,
                for: indexPath
            ) as? CategoryHeader else {
                fatalError("Error with getting CategoryHeader")
            }
            categoryHeader = header
            header.delegate = self
            return header
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        output.catchItemsThatVisible(collectionView.indexPathsForVisibleItems)
    }
}

// MARK: - CategoryHeaderDelegate
extension MenuViewController: CategoryHeaderDelegate {
    func getCategoryCount() -> Int {
        output.getCategoryCount()
    }
    
    func getCategoryName(at position: IndexPath) -> String {
        output.getCategoryName(at: position)
    }
    
    func tapAtCategory(at position: IndexPath) {
        output.tapAtCategory(at: position)
    }
}
