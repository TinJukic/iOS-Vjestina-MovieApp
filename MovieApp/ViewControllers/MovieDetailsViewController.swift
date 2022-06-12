//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by FIVE on 20.03.2022..
//

import Foundation
import UIKit
import PureLayout
import CoreData

protocol MovieDetailsViewControllerProtocol {
    func reloadCollection()
}

class MovieDetailsViewController: UIViewController {
    var id: Int!
    var movieDetails: DetailsForMovie!
    var networkService: NetworkService!
    var context: NSManagedObjectContext!
    var repository: MoviesRepository!
    var delegate: MovieDetailsViewControllerProtocol?
    
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
    
    // animacije
    private var titleWidthConstraint: NSLayoutConstraint!
    private var titleHeightConstraint: NSLayoutConstraint!
    
    convenience init() {
        self.init(id: 0)
    }
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(button: UIButton) {
        self.repository.moviesDatabaseDataSource?.updateFavorite(withId: Int64(self.id))
        let movie = self.repository.moviesDatabaseDataSource?.fetchMovie(withId: Int64(self.id))
        
        if movie?.favorite == false {
            let starImage = UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            UIView.animate(withDuration: 1, delay: 0, animations: {
                button.transform = button.transform.translatedBy(x: 0, y: 0)
                button.setImage(starImage, for: .normal)
            }, completion: { _ in
                UIView.animate(withDuration: 1, delay: 0, animations: {
                    button.transform = CGAffineTransform.identity
                }, completion: nil)
            })
        } else {
            let starImage = UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            UIView.animate(withDuration: 1, delay: 0, animations: {
                button.transform = button.transform.translatedBy(x: 0, y: 0)
                button.setImage(starImage, for: .normal)
            }, completion: { _ in
                UIView.animate(withDuration: 1, delay: 0, animations: {
                    button.transform = CGAffineTransform.identity
                }, completion: nil)
            })
        }
        
        delegate?.reloadCollection()
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
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.repository = MoviesRepository(managedContext: context)
        
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.movieNameLabel.transform = .identity
        })
        
        UIView.animate(withDuration: 1, delay: 0.5, animations: {
            self.shortDescription.transform = .identity
        })
        
        UIView.animate(withDuration: 1, delay: 0.75, options: .curveEaseInOut, animations: {
            self.genreLabel.transform = .identity
        })
    }
    
    func fetchData() {
        // priprema podataka za dohvat
        networkService = NetworkService()
        let movieDescriptionUrlString = "https://api.themoviedb.org/3/movie/" + String(id) + "?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let movieDescriptionUrl = URL(string: movieDescriptionUrlString) else { return }
        var movieDescriptionUrlRequest = URLRequest(url: movieDescriptionUrl)
        movieDescriptionUrlRequest.httpMethod = "GET"
        movieDescriptionUrlRequest.setValue("movie/" + String(id) + "/recommendations/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(movieDescriptionUrlRequest) { (result: Result<DetailsForMovie, RequestError>) in
            switch result {
            case .success(let success):
                self.movieDetails = success
                DispatchQueue.main.async {
                    self.buildViews()
                    self.addConstraints()
                }
            case .failure(let failure):
                print("failure in MovieDetailsViewController \(failure)")
            }
        }
    }
    
    func buildViews() {
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // PRVA POLOVICA
        imageView = UIImageView()
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://image.tmdb.org/t/p/original" + self.movieDetails.posterPath!)!
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            } catch {
                print(error)
            }
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
        userScorePercLabel.text = String(Int(100 - movieDetails.voteAverage!))
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
        var boldText = NSAttributedString(string: movieDetails.title! + " ", attributes: boldAttribute)
        var regularText = NSAttributedString(string: String(movieDetails.releaseDate!.split(separator: "-")[0]), attributes: regularAttribute)
        let movieNameYearString = NSMutableAttributedString()
        movieNameYearString.append(boldText)
        movieNameYearString.append(regularText)
        movieNameLabel.attributedText = movieNameYearString
        movieNameLabel.textColor = .white
        movieNameLabel.numberOfLines = 0
        view.addSubview(movieNameLabel)
        movieNameLabel.transform = movieNameLabel.transform.translatedBy(x: view.frame.width * 2, y: -view.frame.height)
        
        shortDescription = UILabel()
        boldAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
           ]
        regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 14.0)!
           ]
        let dateSplit = movieDetails.releaseDate!.split(separator: "-")
        let dateCountry = String(dateSplit[2]) + "/" + String(dateSplit[1]) + "/" + String(dateSplit[0]) + " (" + String(movieDetails.originalLanguage!) + ")"
        regularText = NSAttributedString(string: dateCountry, attributes: regularAttribute)
        let shortDescriptionString = NSMutableAttributedString()
        shortDescriptionString.append(regularText)
        shortDescription.attributedText = shortDescriptionString
        shortDescription.textColor = .white
        shortDescription.numberOfLines = 0
        view.addSubview(shortDescription)
        shortDescription.transform = shortDescription.transform.translatedBy(x: view.frame.width * 2, y: -view.frame.height)
        
        genreLabel = UILabel()
        var genresString = ""
        movieDetails.genres!.forEach({ genre in
            genresString.append(contentsOf: genre.name)
            if(genre.name != movieDetails.genres![self.movieDetails.genres!.count - 1].name) {
                genresString += ", "
            } else {
                genresString += " "
            }
        })
        regularText = NSAttributedString(string: genresString, attributes: regularAttribute)
        boldText = NSAttributedString(string: String(movieDetails.runtime!) + " min", attributes: boldAttribute)
        let genreDescriptionString = NSMutableAttributedString()
        genreDescriptionString.append(regularText)
        genreDescriptionString.append(boldText)
        genreLabel.attributedText = genreDescriptionString
        genreLabel.textColor = .white
        genreLabel.numberOfLines = 0
        view.addSubview(genreLabel)
        genreLabel.transform = genreLabel.transform.translatedBy(x: view.frame.width * 2, y: -view.frame.height)
        
        yearAndCountryLabel = UILabel()
        yearAndCountryLabel.text = dateCountry
        yearAndCountryLabel.textColor = .white
        view.addSubview(yearAndCountryLabel)
        
        var starImage = UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let movie = self.repository.moviesDatabaseDataSource?.fetchMovie(withId: Int64(self.id))
        if movie?.favorite == false {
            starImage = UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
        
        favoritesButton = UIButton()
        favoritesButton.setImage(starImage, for: .normal)
        favoritesButton.backgroundColor = .gray
        favoritesButton.layer.cornerRadius = 16
        favoritesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        descriptionText.text = movieDetails.overview!
        descriptionText.font = UIFont.init(name: descriptionText.font.fontName, size: 14)
        descriptionText.numberOfLines = 0
        view.addSubview(descriptionText)
        
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
        movieNameLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        movieNameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 159)
        
        shortDescription.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        shortDescription.autoPinEdge(.top, to: .bottom, of: movieNameLabel, withOffset: 3)
        
        genreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 18)
        genreLabel.autoPinEdge(.top, to: .bottom, of: shortDescription, withOffset: 3)
        
        favoritesButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
        favoritesButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 15)
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
