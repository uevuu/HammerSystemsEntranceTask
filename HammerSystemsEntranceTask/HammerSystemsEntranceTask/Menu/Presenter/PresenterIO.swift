//
//  PresenterIO.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import Foundation

protocol MenuViewInput: AnyObject {
    func reloadSections()
    func scrollTo(position: IndexPath)
    func scrollHeaderTo(_ position: IndexPath)
}

protocol MenuViewOutput: AnyObject {
    func viewDidLoadEvent()
    func tapAtCategory(at position: IndexPath)
    func getNumberOfSections() -> Int
    func getNumberOfItemsInSection(at section: Int) -> Int
    func getRecipe(at position: IndexPath) -> Recipe
    func getCategoryCount() -> Int
    func getCategoryName(at position: IndexPath) -> String
    func catchItemsThatVisible(_ items: [IndexPath])
}
