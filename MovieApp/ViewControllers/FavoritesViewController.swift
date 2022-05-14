//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by FIVE on 24.04.2022..
//

import Foundation
import UIKit
import PureLayout

class FavoritesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        navigationItem.title = "TMDB"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        buildViews()
        addConstraints()
    }
    
    func buildViews() {
        
    }
    
    func addConstraints() {
        
    }
}
