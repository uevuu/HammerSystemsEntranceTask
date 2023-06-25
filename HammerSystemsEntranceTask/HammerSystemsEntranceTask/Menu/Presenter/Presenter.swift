//
//  Presenter.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import Foundation

final class MenuPresenter {
    private let networkService: NetworkService
    private let localDataStore: UserDefaultsService
    private var recipes: [Recipe] = []
    private var category: [String] = []
    private var scrollTarget = 0
    private var lockCatching = false
    private var selectedCategory: String?
    weak var view: MenuViewInput?
    
    init(networkService: NetworkService, localDataStore: UserDefaultsService) {
        self.networkService = networkService
        self.localDataStore = localDataStore
        self.recipes = localDataStore.getRecipes()
        self.category = localDataStore.getCategory()
    }
}

extension MenuPresenter: MenuViewOutput {
    func viewDidLoadEvent() {
        networkService.getRecipes { [weak self] result in
            switch result {
            case .success(let response):
                let recipes = response.recipes
                let sortedRecipes = recipes.sorted { $0.sourceName < $1.sourceName }
                let sourceNames = Array(Set(recipes.map { $0.sourceName })).sorted()
                
                self?.localDataStore.saveRecipes(sortedRecipes)
                self?.localDataStore.saveCategory(sourceNames)
                self?.recipes = sortedRecipes
                self?.category = sourceNames
                self?.selectedCategory = sourceNames.first
                self?.view?.reloadSections()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNumberOfSections() -> Int {
        return 2
    }
    
    func getNumberOfItemsInSection(at section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return recipes.count
        default:
            return 0
        }
    }
    
    func getRecipe(at position: IndexPath) -> Recipe {
        return recipes[position.item]
    }
    
    func getCategoryCount() -> Int {
        return category.count
    }
    
    func getCategoryName(at position: IndexPath) -> String {
        return category[position.item]
    }
    
    func tapAtCategory(at position: IndexPath) {
        selectedCategory = category[position.item]
        if let firstRecipeIndex = recipes.firstIndex(where: { $0.sourceName == selectedCategory }) {
            scrollTarget = firstRecipeIndex
            lockCatching = true
            view?.scrollTo(position: IndexPath(item: firstRecipeIndex, section: 1))            
        }
    }

    
    func catchItemsThatVisible(_ items: [IndexPath]) {
        if items.filter({ $0.section == 1 }) .map({ $0.item }) .min() ?? 0 == scrollTarget {
            lockCatching = false
        }
        if lockCatching {
            return 
        }
        let minItemFromCategory = items.filter { $0.section == 1 } .map { $0.item } .min() ?? 0
        if let newPosition = category.firstIndex(where: { $0 == recipes[minItemFromCategory].sourceName }) {
            if let previousSelectedCategory = selectedCategory, let oldPosition = category.firstIndex(where: { $0 == previousSelectedCategory }) {
                if oldPosition != newPosition {
                    selectedCategory = category[newPosition]
                    view?.scrollHeaderTo(IndexPath(
                        item: newPosition,
                        section: 0
                    ))
                }
            }
        }
    }
}
