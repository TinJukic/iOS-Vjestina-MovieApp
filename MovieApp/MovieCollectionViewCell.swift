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
    var pictureURL = ""
    var moviesList: [MovieModel] = []
    var cell: UICollectionViewCell!
    
    init(pictureURL: String, cell: UICollectionViewCell) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGreen
        self.pictureURL = pictureURL
        self.moviesList = Movies.all()
        self.cell = cell
        
        print("Cell...")
        print(pictureURL)
        print()
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        // potrebno je dohvatiti sliku filma i staviti ju na view od kraja do kraja
        self.autoSetDimensions(to: CGSize(width: cell.bounds.width, height: cell.bounds.height))
        
        likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
//        likeButton.backgroundColor = .gray
//        likeButton.layer.cornerRadius = 16
        self.addSubview(likeButton)
        
//        moviePicture = UIImageView()
//        do {
//            let url = URL(string: pictureURL)!
//            let data = try Data(contentsOf: url)
//            moviePicture.image = UIImage(data: data)
//        }
//        catch{
//            print(error)
//        }
//        self.addSubview(moviePicture)
    }
    
    func addConstraints() {
        
//        moviePicture.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
//        moviePicture.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
//        moviePicture.autoSetDimensions(to: CGSize(width: cell.bounds.width, height: cell.bounds.height))
        
        likeButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        likeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        
        self.layer.cornerRadius = 10
    }
}
