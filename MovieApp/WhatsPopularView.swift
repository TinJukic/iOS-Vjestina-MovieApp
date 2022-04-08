//
//  WhatsPopularView.swift
//  MovieApp
//
//  Created by FIVE on 07.04.2022..
//

import Foundation
import UIKit
import PureLayout

class WhatsPopularView: UIView {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .lightGray
        
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
        
        streamingButton = UIButton()
        streamingButton.setTitle("Streaming", for: .normal)
        streamingButton.setTitleColor(.black, for: .normal)
        streamingButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        streamingButton.addTarget(self, action: #selector(streamingButtonPressed), for: .touchUpInside)
        streamingButton.isHidden = false
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
        
        moviesCollectionView = UICollectionView()
    }
    
    func addConstraints() {
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        whatsPopularStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularStackView.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
    }
}
