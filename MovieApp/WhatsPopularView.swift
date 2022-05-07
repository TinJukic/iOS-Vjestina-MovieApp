//
//  WhatsPopularView.swift
//  MovieApp
//
//  Created by FIVE on 07.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class WhatsPopularView: UIView {
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
    
    var whatsPopularLabel: UILabel!
    var streamingButton: UIButton!
    var onTVButton: UIButton!
    var forRentButton: UIButton!
    var inTheatersButton: UIButton!
    var whatsPopularStackView: UIStackView!
    var moviesCollectionView: UICollectionView!
    var buttonList:[UIButton] = []
    let cellIdentifier = "cellId"
    var cellHeight = 0.0
    var selectedCategory = "Streaming"
    var genres: Genres!
    var stackScrollView: UIScrollView!
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
                print("failure in WhatsPopularView \(failure)")
            }
        }
    }
    
    func changeGenre(newGenre: String) {
        self.genres.genres.forEach({
            if($0.name == newGenre) {
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
        // dohvat podataka za filmove i njihov prikaz
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/popular/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.moviesSearchResult = success
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
            case .failure(let failure):
                print("failure in WhatsPopularView \(failure)")
            }
        }
        
        isUserInteractionEnabled = true
        
        stackScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .white
            return v
        }()
        
        whatsPopularLabel = UILabel()
        whatsPopularLabel.text = "What's popular"
        whatsPopularLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(whatsPopularLabel)
        
        whatsPopularStackView = UIStackView()
        whatsPopularStackView.axis = .horizontal
        whatsPopularStackView.alignment = .fill
        whatsPopularStackView.distribution = .fillEqually
        whatsPopularStackView.spacing = 10
        
        self.genres.genres.forEach({ genre in
            let genreButton = UIButton()
            genreButton.setTitle(genre.name, for: .normal)
            genreButton.setTitleColor(.black, for: .normal)
            genreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            genreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.buttonList.append(genreButton)
            self.whatsPopularStackView.addArrangedSubview(genreButton)
        })
        buttonList[0].titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        stackScrollView.addSubview(whatsPopularStackView)
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
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        whatsPopularStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        whatsPopularStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        whatsPopularStackView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        whatsPopularStackView.autoMatch(.height, to: .height, of: stackScrollView)
        
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        stackScrollView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        stackScrollView.autoSetDimension(.height, toSize: 30)
        
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: whatsPopularStackView, withOffset: 8)
        moviesCollectionView.autoSetDimension(.height, toSize: 180, relation: .greaterThanOrEqual)
    }
}

extension WhatsPopularView: UICollectionViewDataSource {
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

extension WhatsPopularView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        
        let movie = self.moviesSearchResult?.results[indexPath.row] ?? MovieDetails.init(adult: nil, backdropPath: nil, genreIds: nil, id: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil)
        let movieDetailsViewsController = MovieDetailsViewController(id: self.moviesSearchResult?.results[indexPath.row].id! ?? 0, movie: movie)
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
    }
}

extension WhatsPopularView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
