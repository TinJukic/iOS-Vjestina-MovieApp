//
//  SearchBarView.swift
//  MovieApp
//
//  Created by FIVE on 03.04.2022..
//

import Foundation
import UIKit
import PureLayout

class SearchBarView: UIView, UITextFieldDelegate {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .lightGray
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // sadrzi cetiri pogleda
        // 1. UIImageView - nalazi se na lijevoj strani pogleda
        // 2. UITextField - nalazi se u sredini pogleda
        // 3. UIButton - nalazi se na desnoj strani pogleda, kao pozadisnku sliku ima postavljen “X”
        // 4. UIButton - nalazi se uz desni rub pogleda, te ima postavljen tekst “Cancel”
    var searchImage: UIImageView!
    var textField: UITextField!
    var xButton: UIButton!
    var cancelButton: UIButton!
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // change properties
        print("Usao sam tu")
        self.xButton.isHidden = false
        self.cancelButton.isHidden = false
    }
    
    private func textFieldShouldEndEditing(_ textField: UITextField) {
        print("A sad sam tu")
//        self.xButton.isHidden = true
//        self.cancelButton.isHidden = true
//        textField.text = "Search"
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    @objc func xButtonPressed() {
        print("X pritisnut!")
        textField.text = ""
    }
    
    @objc func cancelButtonPressed() {
        print("Cancel pritisnut!")
        self.xButton.isHidden = true
        self.cancelButton.isHidden = true
        textField.text = "Search"
        textField.resignFirstResponder()
    }
    
    func buildViews() {
        searchImage = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImage.tintColor = .darkGray
        addSubview(searchImage)
        
        textField = UITextField()
        textField.delegate = self
        textField.text = "Search"
        textField.textColor = .darkGray
        addSubview(textField)
        
        xButton = UIButton()
        xButton.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        xButton.setTitle("X", for: .normal)
        xButton.isHidden = true
        xButton.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
        addSubview(xButton)
                
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.isHidden = true
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        addSubview(cancelButton)
    }
    
    func addConstraints() {
        searchImage.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 11.84)
        searchImage.autoPinEdge(toSuperviewSafeArea: .top, withInset: 12.84)
        searchImage.autoSetDimensions(to: CGSize(width: 20.31, height: 20.31))
        
        textField.autoPinEdge(.leading, to: .trailing, of: searchImage, withOffset: 10.84)
        textField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 121)
        textField.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        textField.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
        
        xButton.autoPinEdge(.leading, to: .trailing, of: textField, withOffset: 20)
        xButton.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16.75)
        xButton.autoSetDimensions(to: CGSize(width: 11.5, height: 11.5))

        cancelButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 18)
        cancelButton.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16.75)
//        cancelButton.autoPinEdge(.leading, to: .trailing, of: xButton, withOffset: 28.75)
        cancelButton.autoSetDimensions(to: CGSize(width: 55, height: 10))
    }
}
