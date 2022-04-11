//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by FIVE on 10.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCollectionViewCell: UIView {
    var moviePicture: UIImageView!
    var likeButton: UIButton!
    var index = 0
    var category = ""
    var moviesList: [MovieModel] = []
    
    init(index: Int, category: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGreen
        self.index = index
        self.category = category
        self.moviesList = Movies.all()
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        // potrebno je dohvatiti sliku filma i staviti ju na view od kraja do kraja
        self.autoSetDimensions(to: CGSize(width: 120, height: 180))
        
//        slika
//        print(moviesList)
        
        likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black), for: .normal)
        self.addSubview(likeButton)
    }
    
    func addConstraints() {
        likeButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        likeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        
        self.layer.cornerRadius = 10
    }
}
