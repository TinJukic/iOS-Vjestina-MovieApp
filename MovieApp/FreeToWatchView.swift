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
    var freeToWatchStackView: UIStackView!
    var buttonList:[UIButton] = []
    
    func unboldButtons(boldedButton: UIButton) {
        buttonList.forEach({
            if($0 != boldedButton) {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        })
    }
    
    @objc func moviesButtonPressed() {
        print("Movies button")
        moviesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        unboldButtons(boldedButton: moviesButton)
    }
    
    @objc func tvButtonPressed() {
        print("TV button")
        tvButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
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
        moviesButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
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
    }
    
    func addConstraints() {
        freeToWatchLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        freeToWatchLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        freeToWatchLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        
        freeToWatchStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        freeToWatchStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        freeToWatchStackView.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel, withOffset: 8)
    }
}
