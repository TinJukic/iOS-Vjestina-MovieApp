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
    var cell: UICollectionViewCell!
    var movie: Movie!
    
    init(cell: UICollectionViewCell, movie: Movie) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        self.cell = cell
        self.movie = movie
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        movieImage = UIImageView()
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://image.tmdb.org/t/p/original" + (self.movie.posterPath ?? ""))!
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data: data)
                }
            } catch {
                print(error)
            }
        }
        self.addSubview(movieImage)
        
        movieTitle = UILabel()
        movieTitle.text = movie.title
        movieTitle.font = UIFont.boldSystemFont(ofSize: 16)
        movieTitle.numberOfLines = 0
        self.addSubview(movieTitle)
        
        movieDescription = UILabel()
        movieDescription.text = movie.overview
        movieDescription.font = UIFont.systemFont(ofSize: 16)
        movieDescription.numberOfLines = 0
        self.addSubview(movieDescription)
    }
    
    func addConstraints() {
        self.autoSetDimensions(to: CGSize(width: cell.bounds.width, height: cell.bounds.height))
        
        movieImage.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        movieImage.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        movieImage.autoSetDimensions(to: CGSize(width: 100, height: 140))
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        
        movieTitle.autoPinEdge(.leading, to: .trailing, of: movieImage, withOffset: 15)
        movieTitle.autoPinEdge(toSuperviewSafeArea: .top, withInset: 13)
        movieTitle.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        
        movieDescription.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        movieDescription.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 15)
        movieDescription.autoPinEdge(.top, to: .bottom, of: movieTitle, withOffset: 5)
        movieDescription.autoPinEdge(.leading, to: .trailing, of: movieImage, withOffset: 15)
        
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.1
    }
}
