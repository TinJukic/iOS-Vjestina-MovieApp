//
//  FreeToWatchView.swift
//  MovieApp
//
//  Created by FIVE on 08.04.2022..
//

import Foundation
import UIKit
import PureLayout

class FreeToWatchView: UIView {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemCyan
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var freeToWatchLabel: UILabel!
    var moviesButton: UIButton!
    var tvButton: UIButton!
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
    
    @objc func moviesButtonPressed() {
        print("Movies button")
        selectedCategory = "Movies"
        moviesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: moviesButton)
    }
    
    @objc func tvButtonPressed() {
        print("TV button")
        selectedCategory = "TV"
        tvButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: tvButton)
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
        freeToWatchStackView.spacing = 5
        self.addSubview(freeToWatchStackView)
        
        moviesButton = UIButton()
        moviesButton.setTitle("Movies", for: .normal)
        moviesButton.setTitleColor(.black, for: .normal)
        moviesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        moviesButton.addTarget(self, action: #selector(moviesButtonPressed), for: .touchUpInside)
        buttonList.append(moviesButton)
        freeToWatchStackView.addArrangedSubview(moviesButton)
        
        tvButton = UIButton()
        tvButton.setTitle("TV", for: .normal)
        tvButton.setTitleColor(.black, for: .normal)
        tvButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tvButton.addTarget(self, action: #selector(tvButtonPressed), for: .touchUpInside)
        buttonList.append(tvButton)
        freeToWatchStackView.addArrangedSubview(tvButton)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .white
        
        var pictureURL = ""
        
        let contentForCell = MovieCollectionViewCell(pictureURL: pictureURL, cell: cell)
        cell.contentView.addSubview(contentForCell)
        cellHeight = cell.bounds.height
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
