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

struct GenreDescription: Codable {
    let id: Int
    let name: String
}

struct Genres: Codable {
    let genres: [GenreDescription]
}

struct MovieDetails: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Popular: Codable {
    let page: Int
    let results: [MovieDetails]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

class WhatsPopularView: UIView {
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
    var selectedCategory = MovieFilter.streaming
    var genres: [Genres]!
    var stackScrollView: UIScrollView!
    
    func unboldButtons(boldedButton: UIButton) {
        buttonList.forEach({
            if($0 != boldedButton) {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        })
    }
    
    @objc func streamingButtonPressed() {
        print("Streaming button")
        selectedCategory = MovieFilter.streaming
        streamingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: streamingButton)
    }
    
    @objc func onTVButtonPressed() {
        print("On TV button")
        selectedCategory = MovieFilter.onTv
        onTVButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: onTVButton)
    }
    
    @objc func forRentButtonPressed() {
        print("For rent button")
        selectedCategory = MovieFilter.forRent
        forRentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: forRentButton)
    }
    
    @objc func inTheatersButtonPressed() {
        print("In theaters button")
        selectedCategory = MovieFilter.inTheaters
        inTheatersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: inTheatersButton)
    }
    
    func buildViews() {
        isUserInteractionEnabled = true
        
        networkService = NetworkService()
        
        stackScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .systemCyan
            return v
        }()
        
        whatsPopularLabel = UILabel()
        whatsPopularLabel.text = "What's popular"
        whatsPopularLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(whatsPopularLabel)
        
        whatsPopularStackView = UIStackView()
        whatsPopularStackView.axis = .horizontal
        whatsPopularStackView.alignment = .fill
        whatsPopularStackView.distribution = .fillProportionally
        whatsPopularStackView.spacing = 12
//        self.addSubview(whatsPopularStackView)
        
        streamingButton = UIButton()
        streamingButton.setTitle("Streaming", for: .normal)
        streamingButton.setTitleColor(.black, for: .normal)
        streamingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        streamingButton.addTarget(self, action: #selector(streamingButtonPressed), for: .touchUpInside)
        buttonList.append(streamingButton)
        whatsPopularStackView.addArrangedSubview(streamingButton)
        
        onTVButton = UIButton()
        onTVButton.setTitle("On TV", for: .normal)
        onTVButton.setTitleColor(.black, for: .normal)
        onTVButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        onTVButton.addTarget(self, action: #selector(onTVButtonPressed), for: .touchUpInside)
        buttonList.append(onTVButton)
        whatsPopularStackView.addArrangedSubview(onTVButton)
        
        forRentButton = UIButton()
        forRentButton.setTitle("For rent", for: .normal)
        forRentButton.setTitleColor(.black, for: .normal)
        forRentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        forRentButton.addTarget(self, action: #selector(forRentButtonPressed), for: .touchUpInside)
        buttonList.append(forRentButton)
        whatsPopularStackView.addArrangedSubview(forRentButton)
        
        inTheatersButton = UIButton()
        inTheatersButton.setTitle("In theaters", for: .normal)
        inTheatersButton.setTitleColor(.black, for: .normal)
        inTheatersButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        inTheatersButton.addTarget(self, action: #selector(inTheatersButtonPressed), for: .touchUpInside)
        buttonList.append(inTheatersButton)
        whatsPopularStackView.addArrangedSubview(inTheatersButton)
        
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
        
        let urlRequestString = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=59afefdb9064ea17898a694d311e247e"
        let urlRequest = URLRequest(url: URL(string: urlRequestString)!)
        networkService.executeUrlRequest(urlRequest) { (result: Result<Genres, RequestError>) in
        switch result {
            case .success(let value):
                self.genres = [value]
            case .failure(let failure):
                print("failure")
            }
        }
    }
    
    func addConstraints() {
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        whatsPopularStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularStackView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        whatsPopularStackView.autoSetDimension(.height, toSize: 20)
        
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        stackScrollView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        stackScrollView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        stackScrollView.autoSetDimension(.height, toSize: 20)
        
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
        let movies = Movies.all()
        return movies.filter({$0.group.contains(MovieGroup.popular)}).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        var movies = Movies.all()
        movies = movies.filter({$0.group.contains(MovieGroup.popular)})
        
        let pictureURL = movies[indexPath.row].imageUrl
        cell.setImageURL(imageURL: pictureURL)
        
        return cell
    }
}

extension WhatsPopularView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
        print("Clicked on cell number \(indexPath.row)")
        
        let movieDetailsViewsController = MovieDetailsViewController()
        movieDetailsViewsController.tabBarController?.selectedIndex = indexPath.row
        
        self.navigationController.pushViewController(movieDetailsViewsController, animated: true)
        
        print("Obavio sam sto sam trebao...")
    }
}

extension WhatsPopularView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
