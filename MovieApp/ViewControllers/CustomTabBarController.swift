//
//  CustomTabBarController.swift
//  MovieApp
//
//  Created by FIVE on 24.04.2022..
//

import Foundation
import UIKit
import PureLayout

class CustomTabBarController: UITabBarController {
    var movieListViewController: MovieListViewController!
    var favoritesViewController: FavoritesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        buildViews()
    }
    
    func buildViews() {
        favoritesViewController = FavoritesViewController()
        movieListViewController = MovieListViewController()
        
        self.viewControllers = [
            createTabBarItem(tabBarTitle: "Home", tabBarImage: UIImage(systemName: "house")!, viewController: movieListViewController),
            createTabBarItem(tabBarTitle: "Favorites", tabBarImage: UIImage(systemName: "heart")!, viewController: favoritesViewController)
        ]
        
        movieListViewController.favoritesView = favoritesViewController.favoritesView
    }
    
    func createTabBarItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationItem.title = "TMDB"
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController.tabBarItem = UITabBarItem(title: tabBarTitle, image: tabBarImage, selectedImage: tabBarImage)
        
        return navigationController
    }
}
