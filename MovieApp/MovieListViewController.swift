//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by FIVE on 03.04.2022..
//

import Foundation
import UIKit
import PureLayout
import Network

// ZADACI:
    // Potrebno je napraviti neke API zahtjeve:
        // 1. popularni filmovi API zahtjev
        // 2. trending filmovi API zahtjev
        // 3. top rated filmovi API zahtjev
        // 4. recommended filmovi API zahtjev
    // Svaki zahtjev napravi u odgovarajucem view-u -> od tamo se dohvacaju svi potrebni podaci za prikaz
    // bazni URL za slike: https://image.tmdb.org/t/p/original, npr. https://image.tmdb.org/t/p/original/ekstpH614fwDX8DUln1a2Opz0N8.jpg
    // filtere je potrebno popuniti listom zanrova koji dobijem API zahtjevom
    // MovieDetailsViewController prikazuje podatke za odabrani film pomocu odgovarajuceg API zahtjeva

class MovieListViewController: UIViewController {
    var searchBarView: SearchBarView!
    var searchMoviesView: SearchMoviesView!
    var movieCategories: MovieCategoriesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
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
        // adding searchBar to the main view
        searchBarView = SearchBarView(delegate: self)
        view.addSubview(searchBarView)

        searchMoviesView = SearchMoviesView()
        searchMoviesView.isHidden = true
        view.addSubview(searchMoviesView)
        
        movieCategories = MovieCategoriesView(navigationController: self.navigationController!)
        view.addSubview(movieCategories)
    }
    
    func addConstraints() {
        searchBarView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        searchBarView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        searchBarView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 22)
        searchBarView.layer.cornerRadius = 10
        
        movieCategories.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        movieCategories.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        movieCategories.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 20)
        movieCategories.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 18)
        
        searchMoviesView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        searchMoviesView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        searchMoviesView.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 20)
    }
}

extension MovieListViewController: SearchBarViewDelegate {
    func didSelectSearchBar() {
        movieCategories.isHidden = true
        searchMoviesView.isHidden = false
    }
    
    func didDeselectSearchBar() {
        movieCategories.isHidden = false
        searchMoviesView.isHidden = true
        
        if let textFieldText = searchBarView.textField.text {
            print(textFieldText)
        }
    }
}
