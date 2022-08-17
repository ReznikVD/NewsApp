//
//  BaseTabBarContoller.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: NewsPageContoller(), title: "News", imageName: "News"),
            createNavController(viewController: UIViewController(), title: "Headlines", imageName: "Headline")
        ]
        
        self.tabBar.standardAppearance = setTabBarAppearance(color: .init(white: 1, alpha: 1))
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = setTabBarAppearance(color: .init(white: 1, alpha: 1))
        }
    }
    
    // MARK: - Methods
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
       
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        return navController
    }
    
    fileprivate func setTabBarAppearance(color: UIColor) -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        return appearance
    }
}
