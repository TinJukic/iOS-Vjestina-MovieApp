//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by FIVE on 03.04.2022..
//

import Foundation
import UIKit
import PureLayout

// Zasto UIStackView moja dva viewa pozicionira jednog na drugog?
// Ne prepoznaje viewe unutar njega?

class MovieListViewController: UIViewController {
    var searchBarView: SearchBarView!
    var whatsPopularView: WhatsPopularView!
    var freeToWatchView: FreeToWatchView!
    var searchMoviesView: SearchMoviesView!
    var stackView: UIStackView!
    
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
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        view.addSubview(stackView)
        
        whatsPopularView = WhatsPopularView()
        stackView.addArrangedSubview(whatsPopularView)
//        view.addSubview(whatsPopularView)
        
        freeToWatchView = FreeToWatchView()
        stackView.addArrangedSubview(freeToWatchView)
//        view.addSubview(freeToWatchView)
        
        searchMoviesView = SearchMoviesView()
        searchMoviesView.isHidden = true
        view.addSubview(searchMoviesView)
    }
    
    func addConstraints() {
        searchBarView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        searchBarView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        searchBarView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 22)
        searchBarView.layer.cornerRadius = 10

        stackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        stackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        stackView.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 20)
        
//        whatsPopularView.autoPinEdge(toSuperviewEdge: .leading, withInset: 18)
//        whatsPopularView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 18)
//        whatsPopularView.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 20)
//
//        freeToWatchView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
//        freeToWatchView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
//        freeToWatchView.autoPinEdge(.top, to: .bottom, of: whatsPopularView, withOffset: 200)
        
        searchMoviesView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        searchMoviesView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        searchMoviesView.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 20)
    }
}

extension MovieListViewController: SearchBarViewDelegate {
    func didSelectSearchBar() {
        stackView.isHidden = true
        searchMoviesView.isHidden = false
    }
    
    func didDeselectSearchBar() {
        stackView.isHidden = false
        searchMoviesView.isHidden = true
        
        if let textFieldText = searchBarView.textField.text {
            print(textFieldText)
        }
    }
}
