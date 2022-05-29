//
//  TrendingView.swift
//  MovieApp
//
//  Created by FIVE on 14.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class UpcomingView: UIView {
    var navigationController: UINavigationController!
    var repository: MoviesRepository!
    var movies: [Movie]!
    var favoritesView: FavoritesView!
    
    init(navigationController: UINavigationController, repository: MoviesRepository) {
        super.init(frame: .zero)
        
        self.navigationController = navigationController
        self.repository = repository
        backgroundColor = .white
        
        let category = repository.moviesDatabaseDataSource?.fetchGroup(groupName: "Recomended")
        if category != nil {
            movies = repository.moviesDatabaseDataSource?.fetchMoviesFromGroup(withCategory: category!)
        } else {
            movies = repository.moviesDatabaseDataSource?.fetchAllMovies()
        }
        
        fetchButtons()
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var upcomingLabel: UILabel!
    var dramaButton: UIButton!
    var thrillerButton: UIButton!
    var horrorButton: UIButton!
    var comedyButton: UIButton!
    var actionButton: UIButton!
    var sciFiButton: UIButton!
    var buttonList:[UIButton] = []
    var upcomingStackView: UIStackView!
    var moviesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var cellHeight = 0.0
    var selectedCategory = "Movies"
    var stackScrollView: UIScrollView!
    var genres: [MovieGenre]!
    var moviesSearchResult: SearchResults?
    
    func fetchButtons() {
        self.genres = self.repository.moviesDatabaseDataSource?.fetchAllGenres()
    }
    
    func changeGenre(newGenre: String) {
        self.genres.forEach({ genre in
            if(genre.name == newGenre) {
                selectedCategory = newGenre
                return
            }
        })
    }
    
    func unboldButtons(boldedButton: UIButton) {
        buttonList.forEach({
            if($0 != boldedButton) {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        })
    }
    
    @objc func buttonTapped(button: UIButton) {
        print("Button \(button.titleLabel?.text ?? "button") tapped!")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: button)
    }
    
    func buildViews() {
        stackScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .white
            return v
        }()
        
        upcomingLabel = UILabel()
        upcomingLabel.text = "Recommended"
        upcomingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(upcomingLabel)
        
        upcomingStackView = UIStackView()
        upcomingStackView.axis = .horizontal
        upcomingStackView.alignment = .fill
        upcomingStackView.distribution = .fillEqually
        upcomingStackView.spacing = 10
        
        self.genres.forEach({ genre in
            let genreButton = UIButton()
            genreButton.setTitle(genre.name, for: .normal)
            genreButton.setTitleColor(.black, for: .normal)
            genreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            genreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.buttonList.append(genreButton)
            self.upcomingStackView.addArrangedSubview(genreButton)
        })
        if buttonList.isEmpty == false {
            buttonList[0].titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
        
        stackScrollView.addSubview(upcomingStackView)
        self.addSubview(stackScrollView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        moviesCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
            collectionViewLayout: flowLayout
        )
        self.addSubview(moviesCollectionView)
        moviesCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
    }
    
    func addConstraints() {
        upcomingLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        upcomingLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        upcomingLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        upcomingStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        upcomingStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        upcomingStackView.autoMatch(.height, to: .height, of: stackScrollView)
        
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        stackScrollView.autoPinEdge(.top, to: .bottom, of: upcomingLabel, withOffset: 8)
        stackScrollView.autoSetDimension(.height, toSize: 30)
        
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: upcomingStackView, withOffset: 8)
        moviesCollectionView.autoSetDimension(.height, toSize: 180)
    }
}

extension UpcomingView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        let pictureURL = "https://image.tmdb.org/t/p/original" + (movies[indexPath.row].posterPath ?? "")
        cell.setImageURL(imageURL: pictureURL)
        cell.movie = movies[indexPath.row]
        
        return cell
    }
}

extension UpcomingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        
        let movie = self.movies[indexPath.row]
        let movieDetailsViewsController = MovieDetailsViewController(id: Int(movie.id))
        movieDetailsViewsController.delegate = self
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
    }
}

extension UpcomingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}

extension UpcomingView: MovieDetailsViewControllerProtocol {
    func reloadCollection() {
        moviesCollectionView.reloadData()
        if favoritesView != nil {
            favoritesView.favoritesCollectionView.reloadData()
        }
    }
}
