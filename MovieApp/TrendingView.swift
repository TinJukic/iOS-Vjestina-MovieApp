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

class TrendingView: UIView {
    var navigationController: UINavigationController!
    var networkService: NetworkService!
    
    init(navigationController: UINavigationController) {
        super.init(frame: .zero)
        
        self.navigationController = navigationController
        backgroundColor = .white
        
        fetchButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var trendingLabel: UILabel!
    var dayButton: UIButton!
    var weekButton: UIButton!
    var monthButton: UIButton!
    var allTimeButton: UIButton!
    var buttonList:[UIButton] = []
    var trendingStackView: UIStackView!
    var moviesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var cellHeight = 0.0
    var selectedCategory = "Movies"
    var stackScrollView: UIScrollView!
    var genres: Genres!
    var moviesSearchResult: SearchResults?
    
    func fetchButtons() {
        networkService = NetworkService()
        
        // dohvat podataka za genres
        let genresUrlRequestString = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=59afefdb9064ea17898a694d311e247e"
        guard let genresUrl = URL(string: genresUrlRequestString) else { return }
        var genresUrlRequest = URLRequest(url: genresUrl)
        genresUrlRequest.httpMethod = "GET"
        genresUrlRequest.setValue("genre/movie/list/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(genresUrlRequest) { (result: Result<Genres, RequestError>) in
        switch result {
            case .success(let value):
                self.genres = value
            DispatchQueue.main.async {
                self.buildViews()
                self.addConstraints()
            }
            case .failure(let failure):
                print("failure in TrendingView \(failure)")
            }
        }
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
        // dohvat podataka za filmove i njihov prikaz
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/trending/movie/day?api_key=59afefdb9064ea17898a694d311e247e&page=1"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("trending/movie/day/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.moviesSearchResult = success
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
            case .failure(let failure):
                print("failure in TrendingView \(failure)")
            }
        }
        
        stackScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .white
            return v
        }()
        
        trendingLabel = UILabel()
        trendingLabel.text = "Trending"
        trendingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(trendingLabel)
        
        trendingStackView = UIStackView()
        trendingStackView.axis = .horizontal
        trendingStackView.alignment = .fill
        trendingStackView.distribution = .fillEqually
        trendingStackView.spacing = 10
        
        self.genres.genres.forEach({ genre in
            let genreButton = UIButton()
            genreButton.setTitle(genre.name, for: .normal)
            genreButton.setTitleColor(.black, for: .normal)
            genreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            genreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.buttonList.append(genreButton)
            self.trendingStackView.addArrangedSubview(genreButton)
        })
        buttonList[0].titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        stackScrollView.addSubview(trendingStackView)
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
        trendingLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        trendingLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        trendingLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        trendingStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        trendingStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        trendingStackView.autoMatch(.height, to: .height, of: stackScrollView)
        
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        stackScrollView.autoPinEdge(.top, to: .bottom, of: trendingLabel, withOffset: 8)
        stackScrollView.autoSetDimension(.height, toSize: 30)
        
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: trendingStackView, withOffset: 8)
        moviesCollectionView.autoSetDimension(.height, toSize: 180)
    }
}

extension TrendingView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesSearchResult?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        let movies = self.moviesSearchResult?.results ?? []
        
        let pictureURL = "https://image.tmdb.org/t/p/original" + movies[indexPath.row].posterPath!
        cell.setImageURL(imageURL: pictureURL)
        
        return cell
    }
}

extension TrendingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        
        let movie = self.moviesSearchResult?.results[indexPath.row] ?? MovieDetails.init(adult: nil, backdropPath: nil, genreIds: nil, id: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil)
        let movieDetailsViewsController = MovieDetailsViewController(id: self.moviesSearchResult?.results[indexPath.row].id! ?? 0, movie: movie)
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
    }
}

extension TrendingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
