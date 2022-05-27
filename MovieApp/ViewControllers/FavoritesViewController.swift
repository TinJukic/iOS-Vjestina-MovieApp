//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by FIVE on 24.04.2022..
//

import Foundation
import UIKit
import PureLayout
import CoreData

class FavoritesViewController: UIViewController {
    var favoritesView: FavoritesView!
    var context: NSManagedObjectContext!
    var moviesRepository: MoviesRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "TMDB"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // zaduzen za spremanjem i pristupom podacima u CoreData
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.moviesRepository = MoviesRepository(managedContext: self.context)
        
        buildViews()
        addConstraints()
    }
    
    func buildViews() {
        favoritesView = FavoritesView(navigationController: self.navigationController!, repository: moviesRepository)
        view.addSubview(favoritesView)
    }
    
    func addConstraints() {
        favoritesView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        favoritesView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        favoritesView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 30)
        favoritesView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
    }
}
