//
//  UserDefaultsService.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 25.06.2023.
//

import Foundation

final class UserDefaultsService {
    private let userDefaults = UserDefaults.standard
    private var lastRecipes: [Recipe]
    private var lastCategory: [String]
    
    init() {
        if let data = UserDefaults.standard.value(forKey: "lastRecipes") as? Data {
            do {
                self.lastRecipes = try PropertyListDecoder().decode([Recipe].self, from: data)
            } catch {
                self.lastRecipes = []
            }
        } else {
            self.lastRecipes = []
        }
        
        if let data = UserDefaults.standard.value(forKey: "lastCategory") as? Data {
            do {
                self.lastCategory = try PropertyListDecoder().decode([String].self, from: data)
            } catch {
                self.lastCategory = []
            }
        } else {
            self.lastCategory = []
        }
    }
    
    func saveRecipes(_ recipes: [Recipe]) {
        lastRecipes = recipes
        UserDefaults.standard.set(try? PropertyListEncoder().encode(lastRecipes), forKey: "lastRecipes")
    }
    
    func getRecipes() -> [Recipe] {
        return lastRecipes
    }
    
    func saveCategory(_ category: [String]) {
        lastCategory = category
        UserDefaults.standard.set(try? PropertyListEncoder().encode(lastRecipes), forKey: "lastCategory")
    }
    func getCategory() -> [String] {
        return lastCategory
    }
}
