//
//  FreeToWatchView.swift
//  MovieApp
//
//  Created by FIVE on 08.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class FreeToWatchView: UIView {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var freeToWatchLabel: UILabel!
    var moviesButton: UIButton!
    var tvButton: UIButton!
    var dramaButton: UIButton!
    var thrillerButton: UIButton!
    var horrorButton: UIButton!
    var comedyButton: UIButton!
    var actionButton: UIButton!
    var sciFiButton: UIButton!
    var freeToWatchStackView: UIStackView!
    var buttonList:[UIButton] = []
    var moviesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var cellHeight = 0.0
    var selectedCategory = "Movies"
    
    func unboldButtons(boldedButton: UIButton) {
        buttonList.forEach({
            if($0 != boldedButton) {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        })
    }
    
    @objc func dramaButtonPressed() {
        print("Drama button")
        selectedCategory = "Drama"
        dramaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: dramaButton)
    }
    
    @objc func thrillerButtonPressed() {
        print("Thriller button")
        selectedCategory = "Thriller"
        thrillerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: thrillerButton)
    }
    
    @objc func horrorButtonPressed() {
        print("Horror button")
        selectedCategory = "Horror"
        horrorButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: horrorButton)
    }
    
    @objc func comedyButtonPressed() {
        print("Comedy button")
        selectedCategory = "Comedy"
        comedyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: comedyButton)
    }
    
    @objc func actionButtonPressed() {
        print("Action button")
        selectedCategory = "Action"
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: actionButton)
    }
    
    @objc func sciFiButtonPressed() {
        print("Sci-fi button")
        selectedCategory = "SciFi"
        sciFiButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: sciFiButton)
    }
    
    func buildViews() {
        freeToWatchLabel = UILabel()
        freeToWatchLabel.text = "Free To Watch"
        freeToWatchLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(freeToWatchLabel)
        
        freeToWatchStackView = UIStackView()
        freeToWatchStackView.axis = .horizontal
        freeToWatchStackView.alignment = .fill
        freeToWatchStackView.distribution = .fillEqually
        freeToWatchStackView.spacing = 1
        self.addSubview(freeToWatchStackView)
        
        dramaButton = UIButton()
        dramaButton.setTitle("Drama", for: .normal)
        dramaButton.setTitleColor(.black, for: .normal)
        dramaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        dramaButton.addTarget(self, action: #selector(dramaButtonPressed), for: .touchUpInside)
        buttonList.append(dramaButton)
        freeToWatchStackView.addArrangedSubview(dramaButton)
        
        thrillerButton = UIButton()
        thrillerButton.setTitle("Thriller", for: .normal)
        thrillerButton.setTitleColor(.black, for: .normal)
        thrillerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        thrillerButton.addTarget(self, action: #selector(thrillerButtonPressed), for: .touchUpInside)
        buttonList.append(thrillerButton)
        freeToWatchStackView.addArrangedSubview(thrillerButton)
        
        horrorButton = UIButton()
        horrorButton.setTitle("Horror", for: .normal)
        horrorButton.setTitleColor(.black, for: .normal)
        horrorButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        horrorButton.addTarget(self, action: #selector(horrorButtonPressed), for: .touchUpInside)
        buttonList.append(horrorButton)
        freeToWatchStackView.addArrangedSubview(horrorButton)
        
        comedyButton = UIButton()
        comedyButton.setTitle("Comedy", for: .normal)
        comedyButton.setTitleColor(.black, for: .normal)
        comedyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        comedyButton.addTarget(self, action: #selector(comedyButtonPressed), for: .touchUpInside)
        buttonList.append(comedyButton)
        freeToWatchStackView.addArrangedSubview(comedyButton)
                
        actionButton = UIButton()
        actionButton.setTitle("Action", for: .normal)
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        buttonList.append(actionButton)
        freeToWatchStackView.addArrangedSubview(actionButton)
        
        sciFiButton = UIButton()
        sciFiButton.setTitle("Sci-fi", for: .normal)
        sciFiButton.setTitleColor(.black, for: .normal)
        sciFiButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sciFiButton.addTarget(self, action: #selector(sciFiButtonPressed), for: .touchUpInside)
        buttonList.append(sciFiButton)
        freeToWatchStackView.addArrangedSubview(sciFiButton)
        
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
        freeToWatchLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        freeToWatchLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        freeToWatchLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        freeToWatchStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        freeToWatchStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        freeToWatchStackView.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel, withOffset: 8)
        
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: freeToWatchStackView, withOffset: 8)
        moviesCollectionView.autoSetDimension(.height, toSize: 180)
    }
}

extension FreeToWatchView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movies = Movies.all()
        return movies.filter({$0.group.contains(MovieGroup.freeToWatch)}).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        var movies = Movies.all()
        movies = movies.filter({$0.group.contains(MovieGroup.freeToWatch)})
        
        let pictureURL = movies[indexPath.row].imageUrl
        cell.setImageURL(imageURL: pictureURL)
        
        return cell
    }
}

extension FreeToWatchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
    }
}

extension FreeToWatchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
