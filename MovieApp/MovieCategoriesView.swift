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
    
    init(navigationController: UINavigationController) {
        super.init(frame: .zero)
        self.navigationController = navigationController
        
        backgroundColor = .white
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var stackView: UIStackView!
    var whatsPopularView: WhatsPopularView!
    var freeToWatchView: FreeToWatchView!
    var trendingView: TrendingView!
    var topRatedView: TopRatedView!
    var upcomingView: UpcomingView!
    
    func buildViews() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        self.addSubview(stackView)
        
        whatsPopularView = WhatsPopularView(navigationController: navigationController)
        stackView.addArrangedSubview(whatsPopularView)
        
        freeToWatchView = FreeToWatchView(navigationController: navigationController)
        stackView.addArrangedSubview(freeToWatchView)
        
        trendingView = TrendingView(navigationController: navigationController)
        stackView.addArrangedSubview(trendingView)
        
        topRatedView = TopRatedView(navigationController: navigationController)
        stackView.addArrangedSubview(topRatedView)
        
        upcomingView = UpcomingView(navigationController: navigationController)
        stackView.addArrangedSubview(upcomingView)
    }
    
    func addConstraints() {
        stackView.autoPinEdgesToSuperviewEdges()
        stackView.autoSetDimension(.width, toSize: 395)
//        stackView.autoSetDimensions(to: CGSize(width: self.bounds.width, height: self.bounds.height))
        
        
    }
}
