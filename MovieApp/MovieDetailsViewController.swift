//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by FIVE on 20.03.2022..
//

import Foundation
import UIKit
import PureLayout

class MovieDetailsViewController: UIViewController {
    var id: Int!
    var movieDetails: DetailsForMovie!
    var networkService: NetworkService!
    var movie: MovieDetails
    
    // PRVA POLOVICA
    var imageView: UIImageView!
    var userScoreLabel: UILabel!
    var userScorePercLabel: UILabel!
    var movieNameLabel: UILabel!
    var shortDescription: UILabel!
    var yearAndCountryLabel: UILabel!
    var genreLabel: UILabel!
    var durationLabel: UILabel!
    var favoritesButton: UIButton!
    
    
    // DRUGA POLOVICA
    var overviewLabel: UILabel!
    var descriptionText: UILabel!
    var overviewSectionView: OverviewView!
    var topFirst: UILabel!
    var topSecond: UILabel!
    var topThird: UILabel!
    var bottomFirst: UILabel!
    var bottomSecond: UILabel!
    var bottomThird: UILabel!
    var verticalStackView: UIStackView!
    var horizontalStackView1: UIStackView!
    var horizontalStackView2: UIStackView!
    
    convenience init() {
        self.init(id: 0, movie: MovieDetails.init(adult: nil, backdropPath: nil, genreIds: [nil], id: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil))
    }
    
    init(id: Int, movie: MovieDetails) {
        self.id = id
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "TMDB"
        navigationItem.backButtonTitle = "back"
        navigationItem.backButtonDisplayMode = .default
        
        self.viewWillAppear(true)
        
        buildViews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // priprema podataka za dohvat
        networkService = NetworkService()
        let movieDescriptionUrlString = "https://api.themoviedb.org/3/movie/" + String(id) + "?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let movieDescriptionUrl = URL(string: movieDescriptionUrlString) else { return }
        var movieDescriptionUrlRequest = URLRequest(url: movieDescriptionUrl)
        movieDescriptionUrlRequest.httpMethod = "GET"
        movieDescriptionUrlRequest.setValue("movie/" + String(id) + "/recommendations/json", forHTTPHeaderField: "Content-Type")
        print(movieDescriptionUrlRequest)
        networkService.executeUrlRequest(movieDescriptionUrlRequest) { (result: Result<DetailsForMovie, RequestError>) in
            switch result {
            case .success(let success):
                self.movieDetails = success
//                print(self.movieDetails)
                DispatchQueue.main.async {
                    self.reloadInputViews()
                }
            case .failure(let failure):
                print("failure in MovieDetailsViewController \(failure)")
            }
        }
        print("ovo ovdje")
        print(self.movieDetails)
    }
    
    func buildViews() {
        print(self.movieDetails)
        
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // dohvat nekad bio tu
        
        // PRVA POLOVICA
//        let pictureURL = "https://image.tmdb.org/t/p/original" + movies[indexPath.row].posterPath!
        imageView = UIImageView(image: UIImage(named: "IronMan"))
        do {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + movie.posterPath!)!
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        userScoreLabel = UILabel()
        userScoreLabel.text = "User Score"
        userScoreLabel.textColor = .white
        userScoreLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(userScoreLabel)
        userScorePercLabel = UILabel()
        userScorePercLabel.text = String(Int(100 - movie.voteAverage!))
        userScorePercLabel.textColor = .white
        userScorePercLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(userScorePercLabel)
        
        movieNameLabel = UILabel()
        var boldAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 24.0)!
           ]
        var regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 24.0)!
           ]
        var boldText = NSAttributedString(string: movie.title! + " ", attributes: boldAttribute)
        var regularText = NSAttributedString(string: String(movie.releaseDate!.split(separator: "-")[0]), attributes: regularAttribute)
        let movieNameYearString = NSMutableAttributedString()
        movieNameYearString.append(boldText)
        movieNameYearString.append(regularText)
        movieNameLabel.attributedText = movieNameYearString
        movieNameLabel.textColor = .white
        view.addSubview(movieNameLabel)
        
        shortDescription = UILabel()
        boldAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
           ]
        regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 14.0)!
           ]
        var dateSplit = movie.releaseDate!.split(separator: "-")
        let dateCountry = String(dateSplit[2]) + "/" + String(dateSplit[1]) + "/" + String(dateSplit[0]) + " (" + String(movie.id!) + ")\n"
        boldText = NSAttributedString(string: "2h 6m", attributes: boldAttribute)
        regularText = NSAttributedString(string: dateCountry + "Action, Science Fiction, Adventure ", attributes: regularAttribute)
        let shortDescriptionString = NSMutableAttributedString()
        shortDescriptionString.append(regularText)
        shortDescriptionString.append(boldText)
        shortDescription.attributedText = shortDescriptionString
        shortDescription.textColor = .white
        shortDescription.numberOfLines = 0
        view.addSubview(shortDescription)
        
        yearAndCountryLabel = UILabel()
        yearAndCountryLabel.text = dateCountry
        yearAndCountryLabel.textColor = .white
        view.addSubview(yearAndCountryLabel)
        genreLabel = UILabel()
        genreLabel.text = "Action, Science Fiction, Adventure"
        genreLabel.textColor = .white
        view.addSubview(genreLabel)
        durationLabel = UILabel()
        durationLabel.text = "2h 6m"
        durationLabel.textColor = .white
        view.addSubview(durationLabel)
        
        let starImage = UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        favoritesButton = UIButton()
        favoritesButton.setImage(starImage, for: .normal)
        favoritesButton.backgroundColor = .gray
        favoritesButton.layer.cornerRadius = 16
        view.addSubview(favoritesButton)
        
        // DRUGA POLOVICA
        verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 15
        view.addSubview(verticalStackView)
        
        horizontalStackView1 = UIStackView()
        horizontalStackView1.axis = .horizontal
        horizontalStackView1.alignment = .fill
        horizontalStackView1.distribution = .fillEqually
        horizontalStackView1.spacing = 5
        view.addSubview(horizontalStackView1)
        
        horizontalStackView2 = UIStackView()
        horizontalStackView2.axis = .horizontal
        horizontalStackView2.alignment = .fill
        horizontalStackView2.distribution = .fillEqually
        horizontalStackView2.spacing = 5
        view.addSubview(horizontalStackView2)
        
        overviewLabel = UILabel()
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.init(name: "Proxima Nova", size: 20)
        overviewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(overviewLabel)
        
        descriptionText = UILabel()
        descriptionText.text = movie.overview
        descriptionText.font = UIFont.init(name: descriptionText.font.fontName, size: 14)
        descriptionText.numberOfLines = 0
        view.addSubview(descriptionText)
        
//        overviewSectionView = OverviewView()
//        view.addSubview(overviewSectionView)
        
        boldAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 14)!
        ]
        regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 14)!
        ]
        
        boldText = NSAttributedString(string: "Don Heck\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Characters", attributes: regularAttribute)
        var text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        topFirst = UILabel()
        topFirst.attributedText = text
        topFirst.numberOfLines = 0
        horizontalStackView1.addArrangedSubview(topFirst)
        
        boldText = NSAttributedString(string: "Jack Kirby\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Characters", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        topSecond = UILabel()
        topSecond.attributedText = text
        topSecond.numberOfLines = 0
        horizontalStackView1.addArrangedSubview(topSecond)
        
        boldText = NSAttributedString(string: "Jon Favreau\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Director", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        topThird = UILabel()
        topThird.attributedText = text
        topThird.numberOfLines = 0
        horizontalStackView1.addArrangedSubview(topThird)
        
        boldText = NSAttributedString(string: "Don Heck\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Screenplay", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        bottomFirst = UILabel()
        bottomFirst.attributedText = text
        bottomFirst.numberOfLines = 0
        horizontalStackView2.addArrangedSubview(bottomFirst)
        
        boldText = NSAttributedString(string: "Jack Marcum\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Screenplay", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        bottomSecond = UILabel()
        bottomSecond.attributedText = text
        bottomSecond.numberOfLines = 0
        horizontalStackView2.addArrangedSubview(bottomSecond)
        
        boldText = NSAttributedString(string: "Matt Holloway\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Screenplay", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        bottomThird = UILabel()
        bottomThird.attributedText = text
        bottomThird.numberOfLines = 0
        horizontalStackView2.addArrangedSubview(bottomThird)
        
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
    }
    
    func addConstraints() {
        // PRVA POLOVICA
        imageView.autoPinEdge(toSuperviewSafeArea: .leading)
        imageView.autoPinEdge(toSuperviewSafeArea: .top)
        imageView.autoPinEdge(toSuperviewSafeArea: .trailing)
        imageView.autoSetDimension(.height, toSize: 303)
        
        userScorePercLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 31)
        userScorePercLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 121)
        
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: userScorePercLabel, withOffset: 15)
        userScoreLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 121)
        
        movieNameLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        movieNameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 159)
        
        shortDescription.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        shortDescription.autoPinEdge(.top, to: .bottom, of: movieNameLabel, withOffset: 3)
        
        favoritesButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
        favoritesButton.autoPinEdge(.top, to: .bottom, of: shortDescription, withOffset: 15)
        favoritesButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        
        // DRUGA POLOVICA
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        overviewLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 20)
        
        descriptionText.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        descriptionText.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 27)
        descriptionText.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8)
        
        verticalStackView.autoPinEdge(.top, to: .bottom, of: descriptionText, withOffset: 22)
        verticalStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        verticalStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
    }
}
