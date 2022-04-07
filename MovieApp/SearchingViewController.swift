//
//  SearchingViewController.swift
//  MovieApp
//
//  Created by FIVE on 06.04.2022..
//

import Foundation
import UIKit
import PureLayout

class SearchingViewController: UIViewController {
    var searchBarView: SearchBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView = SearchBarView()
        view.addSubview(searchBarView)
    }
}
