//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by FIVE on 03.04.2022..
//

import Foundation
import UIKit
import PureLayout

class MovieListViewController: UIViewController {
    var searchBarView: SearchBarView!
    var whatsPopularView: WhatsPopularView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "TMDB"
        
        buildViews()
        addConstraints()
    }
    
    func buildViews() {
        // adding searchBar to the main view
        searchBarView = SearchBarView()
        view.addSubview(searchBarView)
        
        whatsPopularView = WhatsPopularView()
        view.addSubview(whatsPopularView)
    }
    
    func addConstraints() {
        if(searchBarView.textField.isSelected) {
            searchBarView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
            searchBarView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 84)
            searchBarView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 22)
            searchBarView.layer.cornerRadius = 10
        } else {
            searchBarView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
            searchBarView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
            searchBarView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 22)
            searchBarView.layer.cornerRadius = 10
            
            whatsPopularView.autoPinEdge(toSuperviewEdge: .leading, withInset: 18)
            whatsPopularView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 18)
            whatsPopularView.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 20)
        }
    }
}
