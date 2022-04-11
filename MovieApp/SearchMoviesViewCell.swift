//
//  SearchMoviesViewCell.swift
//  MovieApp
//
//  Created by FIVE on 11.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class SearchMoviesViewCell: UIView {
    var movieImage: UIImageView!
    var movieTitle: UILabel!
    var movieDescription: UILabel!
    var index = 0
    var moviesList: [MovieModel] = []
    
    init(index: Int) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGreen
        
        self.index = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        movieTitle = UILabel()
        movieTitle.text = "Tu sam"
        self.addSubview(movieTitle)
    }
    
    func addConstraints() {
        self.autoSetDimensions(to: CGSize(width: 325, height: 140))
        self.layer.cornerRadius = 10
        
        movieTitle.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        movieTitle.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
    }
}
