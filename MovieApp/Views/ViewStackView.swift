//
//  ViewStackView.swift
//  MovieApp
//
//  Created by FIVE on 30.04.2022..
//

import Foundation
import UIKit
import PureLayout

class ViewStackView: UIView {
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
    
    var stackView: UIStackView!
    var whatsPopularView: WhatsPopularView!
    var trendingView: TrendingView!
    var topRatedView: TopRatedView!
    var upcomingView: UpcomingView!
    var favoritesView: FavoritesView!
    
    func buildViews() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        self.addSubview(stackView)
        
        whatsPopularView = WhatsPopularView(navigationController: navigationController, repository: repository)
        whatsPopularView.favoritesView = self.favoritesView
        stackView.addArrangedSubview(whatsPopularView)
        
        trendingView = TrendingView(navigationController: navigationController, repository: repository)
        stackView.addArrangedSubview(trendingView)
        
        topRatedView = TopRatedView(navigationController: navigationController, repository: repository)
        stackView.addArrangedSubview(topRatedView)
        
        upcomingView = UpcomingView(navigationController: navigationController, repository: repository)
        stackView.addArrangedSubview(upcomingView)
    }
    
    func addConstraints() {
        stackView.autoPinEdgesToSuperviewEdges()
    }
}
