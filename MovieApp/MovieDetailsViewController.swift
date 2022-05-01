//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by FIVE on 20.03.2022..
//

import Foundation
import UIKit
import PureLayout

struct DetailsForMovie: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: Bool
    let budget: Int
    let genres: Genres
    let homepage: String
    let id: Int
    let imdbId: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String
    let productionCompanies: ProductionCompanies
    let productionCountries: ProductionCountries
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let spokenLanguages: SpokenLanguages
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_language"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct ProductionCompanies: Codable {
    let productionCompanies: [ProductionCompanie]
}

struct ProductionCompanie: Codable {
    let id: Int
    let logoPath: String
    let name: String
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountries: Codable {
    let productionCountries: [ProductionCountry]
}

struct ProductionCountry: Codable {
    let iso31661: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguages: Codable {
    let spokenLanguages: [SpokenLanguage]
}

struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

class MovieDetailsViewController: UIViewController {
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
        
        buildViews()
        addConstraints()
    }
    
    func buildViews() {
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // PRVA POLOVICA
        imageView = UIImageView(image: UIImage(named: "IronMan"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        userScoreLabel = UILabel()
        userScoreLabel.text = "User Score"
        userScoreLabel.textColor = .white
        userScoreLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(userScoreLabel)
        userScorePercLabel = UILabel()
        userScorePercLabel.text = "76%"
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
        var boldText = NSAttributedString(string: "Iron man ", attributes: boldAttribute)
        var regularText = NSAttributedString(string: "(2008)", attributes: regularAttribute)
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
        boldText = NSAttributedString(string: "2h 6m", attributes: boldAttribute)
        regularText = NSAttributedString(string: "05/02/2008 (US)\nAction, Science Fiction, Adventure ", attributes: regularAttribute)
        let shortDescriptionString = NSMutableAttributedString()
        shortDescriptionString.append(regularText)
        shortDescriptionString.append(boldText)
        shortDescription.attributedText = shortDescriptionString
        shortDescription.textColor = .white
        shortDescription.numberOfLines = 0
        view.addSubview(shortDescription)
        
        yearAndCountryLabel = UILabel()
        yearAndCountryLabel.text = "05/02/2008 (US)"
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
        descriptionText.text = "After beeing held captive in an Afganistan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
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
