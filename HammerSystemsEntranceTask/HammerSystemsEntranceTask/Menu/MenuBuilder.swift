//
//  MenuBuilder.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import UIKit

// MARK: - MenuBuilder
final class MenuBuilder {
    func build() -> UIViewController {
        let presenter = MenuPresenter(networkService: NetworkService(), localDataStore: UserDefaultsService())
        let viewController = MenuViewController(output: presenter)
        presenter.view = viewController
        return viewController
    }
}
