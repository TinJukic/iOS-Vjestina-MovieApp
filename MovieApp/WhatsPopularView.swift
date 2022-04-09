//
//  WhatsPopularView.swift
//  MovieApp
//
//  Created by FIVE on 07.04.2022..
//

import Foundation
import UIKit
import PureLayout

// Kako dodati UICollectionView na moj view?
// Primjer prepisan iz skripte

class WhatsPopularView: UIView {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemYellow
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var whatsPopularLabel: UILabel!
    @objc var streamingButton: UIButton!
    var onTVButton: UIButton!
    var forRentButton: UIButton!
    var inTheatersButton: UIButton!
    var whatsPopularStackView: UIStackView!
    var moviesCollectionView: UICollectionView!
    var buttonList:[UIButton] = []
    let cellIdentifier = "cellId"
    
    func unboldButtons(boldedButton: UIButton) {
        buttonList.forEach({
            if($0 != boldedButton) {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        })
    }
    
    @objc func streamingButtonPressed() {
        print("Streaming button")
        streamingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: streamingButton)
    }
    
    @objc func onTVButtonPressed() {
        print("On TV button")
        onTVButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: onTVButton)
    }
    
    @objc func forRentButtonPressed() {
        print("For rent button")
        forRentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: forRentButton)
    }
    
    @objc func inTheatersButtonPressed() {
        print("In theaters button")
        inTheatersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: inTheatersButton)
    }
    
    func buildViews() {
        isUserInteractionEnabled = true
        
        whatsPopularLabel = UILabel()
        whatsPopularLabel.text = "What's popular"
        whatsPopularLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(whatsPopularLabel)
        
        whatsPopularStackView = UIStackView()
        whatsPopularStackView.axis = .horizontal
        whatsPopularStackView.alignment = .fill
        whatsPopularStackView.distribution = .fillEqually
        whatsPopularStackView.spacing = 5
        self.addSubview(whatsPopularStackView)
        
//        UISegmentedControll umjesto UIButtona
        
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
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        moviesCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
            collectionViewLayout: flowLayout
        )
        moviesCollectionView.backgroundColor = .white
        self.addSubview(moviesCollectionView)
        moviesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.backgroundColor = .systemRed
    }
    
    func addConstraints() {
        self.bounds.size.height = 100
        
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        whatsPopularStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularStackView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        
//        moviesCollectionView.autoPinEdgesToSuperviewEdges()
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 0)
        moviesCollectionView.autoPinEdge(.top, to: .bottom, of: whatsPopularStackView, withOffset: 20)
    }
}

extension WhatsPopularView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

extension WhatsPopularView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
    }
}

extension WhatsPopularView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row + 1
        return CGSize(width: row * 10, height: row * 10)
    }
}
