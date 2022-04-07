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
    
    @objc func streamingButtonPressed() {
        print("Streaming button")
        streamingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    @objc func onTVButtonPressed() {
        print("On TV button")
        onTVButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    @objc func forRentButtonPressed() {
        print("For rent button")
        forRentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func buildViews() {
        whatsPopularLabel = UILabel()
        whatsPopularLabel.text = "What's popular"
        whatsPopularLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(whatsPopularLabel)
        
        streamingButton = UIButton()
        streamingButton.setTitle("Streaming", for: .normal)
        streamingButton.setTitleColor(.black, for: .normal)
        streamingButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        streamingButton.addTarget(self, action: #selector(streamingButtonPressed), for: .touchUpInside)
        streamingButton.isHidden = false
        self.addSubview(streamingButton)
        
        onTVButton = UIButton()
        onTVButton.setTitle("On TV", for: .normal)
        onTVButton.setTitleColor(.black, for: .normal)
        onTVButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        onTVButton.addTarget(self, action: #selector(onTVButtonPressed), for: .touchUpInside)
        self.addSubview(onTVButton)
        
        forRentButton = UIButton()
        forRentButton.setTitle("For rent", for: .normal)
        forRentButton.setTitleColor(.black, for: .normal)
        forRentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        forRentButton.addTarget(self, action: #selector(forRentButtonPressed), for: .touchUpInside)
        self.addSubview(forRentButton)
    }
    
    func addConstraints() {
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        whatsPopularLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        streamingButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        streamingButton.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        streamingButton.autoSetDimensions(to: CGSize(width: 75, height: 20))
        
        onTVButton.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        onTVButton.autoPinEdge(.leading, to: .trailing, of: streamingButton, withOffset: 22)
        onTVButton.autoSetDimensions(to: CGSize(width: 50, height: 20))
        
        forRentButton.autoPinEdge(.top, to: .bottom, of: whatsPopularLabel, withOffset: 8)
        forRentButton.autoPinEdge(.leading, to: .trailing, of: onTVButton, withOffset: 23)
        forRentButton.autoSetDimensions(to: CGSize(width: 60, height: 20))
    }
}
