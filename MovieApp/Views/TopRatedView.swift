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

class TopRatedView: UIView {
    var navigationController: UINavigationController!
    var repository: MoviesRepository!
    var movies: [Movie]!
    
    init(navigationController: UINavigationController, repository: MoviesRepository) {
        super.init(frame: .zero)
        
        self.navigationController = navigationController
        self.repository = repository
        backgroundColor = .white
        
        let category = repository.moviesDatabaseDataSource?.fetchGroup(groupName: "Top rated")
        movies = repository.moviesDatabaseDataSource?.fetchMoviesFromGroup(withCategory: category!)
        
        fetchButtons()
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topRatedLabel: UILabel!
    var dayButton: UIButton!
    var weekButton: UIButton!
    var monthButton: UIButton!
    var allTimeButton: UIButton!
    var buttonList:[UIButton] = []
    var topRatedStackView: UIStackView!
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
        
        topRatedLabel = UILabel()
        topRatedLabel.text = "Top rated"
        topRatedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(topRatedLabel)
        
        topRatedStackView = UIStackView()
        topRatedStackView.axis = .horizontal
        topRatedStackView.alignment = .fill
        topRatedStackView.distribution = .fillEqually
        topRatedStackView.spacing = 10
        
        self.genres.forEach({ genre in
            let genreButton = UIButton()
            genreButton.setTitle(genre.name, for: .normal)
            genreButton.setTitleColor(.black, for: .normal)
            genreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            genreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.buttonList.append(genreButton)
            self.topRatedStackView.addArrangedSubview(genreButton)
        })
        if buttonList.isEmpty == false {
            buttonList[0].titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
        
        stackScrollView.addSubview(topRatedStackView)
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
        topRatedLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        topRatedLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        topRatedLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        topRatedStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        topRatedStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        topRatedStackView.autoMatch(.height, to: .height, of: stackScrollView)
        
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        stackScrollView.autoPinEdge(.top, to: .bottom, of: topRatedLabel, withOffset: 8)
        stackScrollView.autoSetDimension(.height, toSize: 30)
        
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: topRatedStackView, withOffset: 8)
        moviesCollectionView.autoSetDimension(.height, toSize: 180)
    }
}

extension TopRatedView: UICollectionViewDataSource {
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

extension TopRatedView: UICollectionViewDelegate {
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

extension TopRatedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}

extension TopRatedView: MovieDetailsViewControllerProtocol {
    func reloadCollection() {
        moviesCollectionView.reloadData()
    }
}
