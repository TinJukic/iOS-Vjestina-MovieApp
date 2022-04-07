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
    // PRVA POLOVICA
    var imageView: UIImageView!
    var userScoreLabel: UILabel!
    var userScorePercLabel: UILabel!
    var movieNameLabel: UILabel!
    var shortDescription: UILabel!
    var yearAndCountryLabel: UILabel!
    var genreLabel: UILabel!
    var durationLabel: UILabel!
//    var circle: UIImageView!
//    var starIcon: UIImageView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
    }
    
    func buildViews() {
        view.backgroundColor = .white
        
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
        
//        let config = UIImage.SymbolConfiguration(pointSize: 32)
//        let circleImage = UIImage(systemName: "circle.fill", withConfiguration: config)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
//        circle = UIImageView(image: circleImage)
//        view.addSubview(circle)
        
        let starImage = UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal)
//        starIcon = UIImageView(image: starImage)
//        view.addSubview(starIcon)
        
        favoritesButton = UIButton()
        favoritesButton.setImage(starImage, for: .normal)
        favoritesButton.backgroundColor = .gray
        favoritesButton.layer.cornerRadius = 16
        view.addSubview(favoritesButton)
        
        // DRUGA POLOVICA
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
        
        boldText = NSAttributedString(string: "Don HeckHeckHeckHeckHeckHeck\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Characters", attributes: regularAttribute)
        var text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        topFirst = UILabel()
        topFirst.attributedText = text
        topFirst.numberOfLines = 0
        view.addSubview(topFirst)
        
        boldText = NSAttributedString(string: "Jack Kirby\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Characters", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        topSecond = UILabel()
        topSecond.attributedText = text
        topSecond.numberOfLines = 0
        view.addSubview(topSecond)
        
        boldText = NSAttributedString(string: "Jon Favreau\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Director", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        topThird = UILabel()
        topThird.attributedText = text
        topThird.numberOfLines = 0
        view.addSubview(topThird)
        
        boldText = NSAttributedString(string: "Don Heck\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Screenplay", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        bottomFirst = UILabel()
        bottomFirst.attributedText = text
        bottomFirst.numberOfLines = 0
        view.addSubview(bottomFirst)
        
        boldText = NSAttributedString(string: "Jack Marcum\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Screenplay", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        bottomSecond = UILabel()
//        bottomSecond.attributedText = text
        bottomSecond.numberOfLines = 0
        view.addSubview(bottomSecond)
        
        boldText = NSAttributedString(string: "Matt Holloway\n", attributes: boldAttribute)
        regularText = NSAttributedString(string: "Screenplay", attributes: regularAttribute)
        text = NSMutableAttributedString()
        text.append(boldText)
        text.append(regularText)
        bottomThird = UILabel()
        bottomThird.attributedText = text
        bottomThird.numberOfLines = 0
        view.addSubview(bottomThird)
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
        
//        starIcon.auto.autoAlignAxis(.vertical, toSameAxisOf: circle)
//        starIcon.autoAlignAxis(.horizontal, toSameAxisOf: circle)
//        starIcon.autoPinEdge(.top, to: .top, of: circle, withOffset: 9)
//        starIcon.autoPinEdge(.leading, to: .leading, of: circle, withOffset: 9)
        
        // DRUGA POLOVICA
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 18)
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        overviewLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 20)
        
        descriptionText.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        descriptionText.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 27)
        descriptionText.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8)
        
        topFirst.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        topFirst.autoPinEdge(.top, to: .bottom, of: descriptionText, withOffset: 22)
        
        topSecond.autoPinEdge(.leading, to: .trailing, of: topFirst, withOffset: 44)
        topSecond.autoPinEdge(.top, to: .bottom, of: descriptionText, withOffset: 22)
        
        topThird.autoPinEdge(.leading, to: .trailing, of: topSecond, withOffset: 55)
        topThird.autoPinEdge(.top, to: .bottom, of: descriptionText, withOffset: 22)
        
        bottomFirst.autoPinEdge(.top, to: .bottom, of: topFirst, withOffset: 26)
        bottomFirst.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        
        bottomSecond.autoPinEdge(.top, to: .bottom, of: topSecond, withOffset: 26)
        bottomSecond.autoPinEdge(.leading, to: .trailing, of: bottomFirst, withOffset: 42)
        
        bottomThird.autoPinEdge(.top, to: .bottom, of: topThird, withOffset: 26)
        bottomThird.autoPinEdge(.leading, to: .trailing, of: bottomSecond, withOffset: 36)    }
}
