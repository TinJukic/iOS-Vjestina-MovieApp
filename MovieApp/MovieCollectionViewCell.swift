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

class MovieCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "cellIdentifier"
    var moviePicture: UIImageView!
    var likeButton: UIButton!
    var likeButtonDimensions = CGSize(width: 30, height: 30)
    var imageURL: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGreen
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        self.moviePicture = nil
    }
    
    public func setImageURL(imageURL: String) {
        moviePicture = UIImageView()
        do {
            let url = URL(string: imageURL)!
            let data = try Data(contentsOf: url)
            moviePicture.image = UIImage(data: data)
        }
        catch{
            print("Doslo je do pogreske")
        }
        self.addSubview(moviePicture)
        
        likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        likeButton.backgroundColor = .gray
        self.addSubview(likeButton)
        
        moviePicture.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        moviePicture.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        moviePicture.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height))
        moviePicture.layer.cornerRadius = 10
        moviePicture.clipsToBounds = true
        
        likeButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        likeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        likeButton.autoSetDimensions(to: likeButtonDimensions)
        likeButton.layer.cornerRadius = likeButtonDimensions.width / 2
        likeButton.clipsToBounds = true
    }
    
    func buildViews() {
        // potrebno je dohvatiti sliku filma i staviti ju na view od kraja do kraja
        self.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height))
    }
    
    func addConstraints() {
        self.layer.cornerRadius = 10
    }
}
