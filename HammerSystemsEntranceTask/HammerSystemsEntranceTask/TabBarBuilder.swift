//
//  TabBarBuilder.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 25.06.2023.
//

import UIKit

//MARK: - TabBarBuilder
final class TabBarBuilder {    
    func build() -> UIViewController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor(named: "PurpleColor")
        let mainBuilder = MenuBuilder()
        let menuViewController = mainBuilder.build()
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        tabBar.addViewController(
            viewController: menuNavigationController,
            title: "Меню",
            image: UIImage(systemName: "fork.knife.circle")
        )
        tabBar.addViewController(
            viewController: UIViewController(),
            title: "Контакты",
            image: UIImage(systemName: "mappin.circle")
        )
        tabBar.addViewController(
            viewController: UIViewController(),
            title: "Профиль",
            image: UIImage(systemName: "person.crop.circle")
        )
        tabBar.addViewController(
            viewController: UIViewController(),
            title: "Корзина",
            image: UIImage(systemName: "cart")
        )
        return tabBar
    }
}

extension UITabBarController {
    func addViewController(
        viewController: UIViewController,
        title: String,
        image: UIImage?
    ) {
        viewController.title = title
        viewController.tabBarItem.image = image
        var viewControllers = self.viewControllers ?? []
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: true)
    }
}
