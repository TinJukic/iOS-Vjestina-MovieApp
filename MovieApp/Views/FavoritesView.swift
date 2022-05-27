//
//  FavoritesView.swift
//  MovieApp
//
//  Created by FIVE on 15.05.2022..
//

import Foundation
import UIKit
import PureLayout

class FavoritesView: UIView {
    var favoritesLabel: UILabel!
    var navigationController: UINavigationController!
    var favoritesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var repository: MoviesRepository!
    var favoritesViewController: FavoritesViewController!
    
    init(navigationController: UINavigationController, repository: MoviesRepository) {
        super.init(frame: .zero)
        
        self.navigationController = navigationController
        self.repository = repository
        
        self.backgroundColor = .white
        
        self.buildViews()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        favoritesLabel = UILabel()
        favoritesLabel.text = "Favorites"
        favoritesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(favoritesLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        favoritesCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
            collectionViewLayout: flowLayout
        )
        self.addSubview(favoritesCollectionView)
        favoritesCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
    }
    
    func addConstraints() {
        favoritesLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        favoritesLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        
        favoritesCollectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        favoritesCollectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        favoritesCollectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        favoritesCollectionView.autoPinEdge(.top, to: .bottom, of: favoritesLabel, withOffset: 20)
        favoritesCollectionView.autoSetDimension(.height, toSize: 180, relation: .greaterThanOrEqual)
    }
}

extension FavoritesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.moviesDatabaseDataSource?.fetchFavorites().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = self.repository.moviesDatabaseDataSource?.fetchFavorites()[indexPath.row]
        
        let pictureURL = "https://image.tmdb.org/t/p/original" + (movie?.posterPath ?? "")
        cell.setImageURL(imageURL: pictureURL)
//        cell.delegate = self
        cell.movie = movie
        
        return cell
    }
}

extension FavoritesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        let movie = self.repository.moviesDatabaseDataSource?.fetchFavorites()[indexPath.row]
        let movieDetailsViewsController = MovieDetailsViewController(id: Int(movie?.id ?? 0))
        movieDetailsViewsController.delegate = self
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
    }
}

extension FavoritesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}

//extension FavoritesView: MovieCollectionViewCellDelegate {
//    func reloadCollection() {
//        print("ETOOOO MEEEEEE")
//        favoritesCollectionView.reloadData()
//    }
//}

extension FavoritesView: MovieDetailsViewControllerProtocol {
    func reloadCollection() {
        favoritesCollectionView.reloadData()
    }
}
