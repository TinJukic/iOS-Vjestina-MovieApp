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

protocol MovieCollectionViewCellDelegate {
    func reloadCollection()
}

class MovieCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "cellIdentifier"
    var moviePicture: UIImageView!
    var likeButton: UIButton!
    var likeButtonDimensions = CGSize(width: 30, height: 30)
    var imageURL: String!
    var delegate: MovieCollectionViewCellDelegate?
    var cell: UICollectionViewCell!
    var movie: Movie!
    var sender: UIView!
//    let repository: MoviesRepository!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemGreen

        buildViews()
        addConstraints()
    }
    
//    init(cell: UICollectionViewCell, movie: Movie) {
//        super.init(frame: cell.frame)
//
//        self.backgroundColor = .white
//
//        self.cell = cell
//        self.movie = movie
//
//        buildViews()
//        addConstraints()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        self.moviePicture = nil
    }
    
    @objc func buttonPressed() {
        delegate?.reloadCollection()
        print("Clicked")
    }
    
    public func setImageURL(imageURL: String) {
        moviePicture = UIImageView()
        DispatchQueue.global().async {
            do {
                let url = URL(string: imageURL)!
                let data = try Data(contentsOf: url)

                DispatchQueue.main.async {
                    self.moviePicture.image = UIImage(data: data)
                }
            }
            catch{
                print("Doslo je do pogreske")
            }
        }
        self.addSubview(moviePicture)

        likeButton = UIButton()
        if movie != nil && movie.favorite == true {
            likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
//        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
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
        likeButton.target(forAction: #selector(buttonPressed), withSender: sender)
    }
    
    func buildViews() {
        // potrebno je dohvatiti sliku filma i staviti ju na view od kraja do kraja
//        let pictureURL = "https://image.tmdb.org/t/p/original" + (movie.posterPath ?? "")
//        print(pictureURL)
////        self.setImageURL(imageURL: pictureURL)
//
//        movieImage = UIImageView()
//        DispatchQueue.global().async {
//            do {
//                let url = URL(string: "https://image.tmdb.org/t/p/original" + (self.movie.posterPath ?? ""))!
//                let data = try Data(contentsOf: url)
//
//                DispatchQueue.main.async {
//                    self.movieImage.image = UIImage(data: data)
//                }
//            } catch {
//                print(error)
//            }
//        }
//        self.addSubview(movieImage)
//        print("Dodao sam sliku")
//
//        likeButton = UIButton()
//        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
//        likeButton.backgroundColor = .gray
//        likeButton.target(forAction: #selector(buttonPressed), withSender: self)
//        self.addSubview(likeButton)
    }
    
    func addConstraints() {
        self.layer.cornerRadius = 10
        self.autoSetDimension(.width, toSize: 120)
        self.autoSetDimension(.height, toSize: 180)
    }
}
