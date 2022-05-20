//
//  SearchMoviesView.swift
//  MovieApp
//
//  Created by FIVE on 08.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

// prilikom pretrazivanja filmova za prikaz, svaki put kada korisnik nesto upise u search bar,
// treba se ponovno pokrenuti dohvat filmova iz baze podataka po imenu filma
// i rezultat te pretrage se treba prikazati -> treba promijeniti da se podaci dohvacaju na promjen
// text fielda unutar SearchBar-a (VALJDA)
// trebam poslati referencu na MoviesRepository i preko njega trebam spremati i dohvacati sve podatke

class SearchMoviesView: UIView {
    var searched: String!
    var moviesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var labela: UILabel!
    var networkService: NetworkService!
    var moviesSearchResult: SearchResults?
    var navigationController: UINavigationController!
    var repository: MoviesRepository!
    
    init(navigationController: UINavigationController, repository: MoviesRepository) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        self.navigationController = navigationController
        self.repository = repository
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        print(repository.moviesDatabaseDataSource?.fetchAllMovies().count)
        
        networkService = NetworkService()
        
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
                print("failure in SearchMoviesView \(failure)")
            }
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        moviesCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
            collectionViewLayout: flowLayout
        )
        self.addSubview(moviesCollectionView)
        moviesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
    }
    
    func addConstraints() {
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        moviesCollectionView.autoSetDimension(.height, toSize: 700, relation: .greaterThanOrEqual)
    }
}

extension SearchMoviesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesSearchResult?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let contentForCell = SearchMoviesViewCell(index: indexPath.row, cell: cell, moviesSearchResult: self.moviesSearchResult ?? SearchResults.init(page: 0, results: [], totalPages: 0, totalResults: 0))
        cell.contentView.addSubview(contentForCell)
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension SearchMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        
        let movie = self.moviesSearchResult?.results[indexPath.row] ?? MovieDetails.init(adult: nil, backdropPath: nil, genreIds: nil, id: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil)
        let movieDetailsViewsController = MovieDetailsViewController(id: self.moviesSearchResult?.results[indexPath.row].id! ?? 0, movie: movie)
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
    }
}

extension SearchMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 140)
    }
}
