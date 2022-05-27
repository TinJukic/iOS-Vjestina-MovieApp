//
//  MovieCategoriesView.swift
//  MovieApp
//
//  Created by FIVE on 14.04.2022..
//

import Foundation
import UIKit
import PureLayout

class MovieCategoriesView: UIScrollView {
    var navigationController: UINavigationController!
    var repository: MoviesRepository!
    
    init(navigationController: UINavigationController, repository: MoviesRepository) {
        super.init(frame: .zero)
        self.navigationController = navigationController
        self.repository = repository
        
        backgroundColor = .white
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var viewStackView: ViewStackView!
    
    func buildViews() {
        viewStackView = ViewStackView(navigationController: navigationController, repository: repository)
        self.addSubview(viewStackView)
    }
    
    func addConstraints() {
        viewStackView.autoPinEdgesToSuperviewEdges()
        viewStackView.autoMatch(.width, to: .width, of: self)
    }
}
