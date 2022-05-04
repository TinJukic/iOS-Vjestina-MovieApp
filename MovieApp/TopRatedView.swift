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
    var networkService: NetworkService!
    
    init(navigationController: UINavigationController) {
        super.init(frame: .zero)
        
        self.navigationController = navigationController
        backgroundColor = .white
        
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
    var genres: Genres!
    var moviesSearchResult: SearchResults!
    
    func unboldButtons(boldedButton: UIButton) {
        buttonList.forEach({
            if($0 != boldedButton) {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        })
    }
    
    @objc func dayButtonPressed() {
        print("Day button")
        selectedCategory = "Day"
        dayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: dayButton)
    }
    
    @objc func weekButtonPressed() {
        print("Week button")
        selectedCategory = "Week"
        weekButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: weekButton)
    }
    
    @objc func monthButtonPressed() {
        print("Month button")
        selectedCategory = "Month"
        monthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: monthButton)
    }
    
    @objc func allTimeButtonPressed() {
        print("All time button")
        selectedCategory = "All time"
        allTimeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: allTimeButton)
    }
    
    func buildViews() {
        networkService = NetworkService()
        
        // dohvat podataka za genres
        let genresUrlRequestString = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=59afefdb9064ea17898a694d311e247e"
        guard let genresUrl = URL(string: genresUrlRequestString) else { return }
        var genresUrlRequest = URLRequest(url: genresUrl)
        genresUrlRequest.httpMethod = "GET"
        genresUrlRequest.setValue("genre/movie/list/json", forHTTPHeaderField: "Content-Type")
        print(genresUrlRequest)
        networkService.executeUrlRequest(genresUrlRequest) { (result: Result<Genres, RequestError>) in
        switch result {
            case .success(let value):
                self.genres = value
            case .failure(let failure):
                print("failure in WhatsPopularView")
            }
        }
        
        // dohvat podataka za filmove i njihov prikaz
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/top_rated/json", forHTTPHeaderField: "Content-Type")
        print()
        print(popularMoviesUrlRequest)
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.moviesSearchResult = success
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
            case .failure(let failure):
                print("failure in TopRatedView")
            }
        }
        
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
        topRatedStackView.spacing = 20
        
        dayButton = UIButton()
        dayButton.setTitle("Day", for: .normal)
        dayButton.setTitleColor(.black, for: .normal)
        dayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        dayButton.addTarget(self, action: #selector(dayButtonPressed), for: .touchUpInside)
        buttonList.append(dayButton)
        topRatedStackView.addArrangedSubview(dayButton)
        
        weekButton = UIButton()
        weekButton.setTitle("Week", for: .normal)
        weekButton.setTitleColor(.black, for: .normal)
        weekButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        weekButton.addTarget(self, action: #selector(weekButtonPressed), for: .touchUpInside)
        buttonList.append(weekButton)
        topRatedStackView.addArrangedSubview(weekButton)
        
        monthButton = UIButton()
        monthButton.setTitle("Month", for: .normal)
        monthButton.setTitleColor(.black, for: .normal)
        monthButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        monthButton.addTarget(self, action: #selector(monthButtonPressed), for: .touchUpInside)
        buttonList.append(monthButton)
        topRatedStackView.addArrangedSubview(monthButton)
        
        allTimeButton = UIButton()
        allTimeButton.setTitle("All time", for: .normal)
        allTimeButton.setTitleColor(.black, for: .normal)
        allTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        allTimeButton.addTarget(self, action: #selector(allTimeButtonPressed), for: .touchUpInside)
        buttonList.append(allTimeButton)
        topRatedStackView.addArrangedSubview(allTimeButton)
        
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
//        let movies = Movies.all()
//        return movies.filter({$0.group.contains(MovieGroup.topRated)}).count
        
        return self.moviesSearchResult.totalResults
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        
//        var movies = Movies.all()
//        movies = movies.filter({$0.group.contains(MovieGroup.topRated)})
        
        let movies = self.moviesSearchResult.results
        
//        let pictureURL = movies[indexPath.row].imageUrl
        let pictureURL = "https://image.tmdb.org/t/p/original" + movies[indexPath.row].posterPath!
        cell.setImageURL(imageURL: pictureURL)
        
        return cell
    }
}

extension TopRatedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        
        let movie = self.moviesSearchResult.results[indexPath.row]
        let movieDetailsViewsController = MovieDetailsViewController(id: self.moviesSearchResult.results[indexPath.row].id!, movie: movie)
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
        
        print("Obavio sam sto sam trebao...")
    }
}

extension TopRatedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
