//
//  SearchMoviesView.swift
//  MovieApp
//
//  Created by FIVE on 08.04.2022..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class SearchMoviesView: UIView {
    var searched: String!
    var moviesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var labela: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
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
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        moviesCollectionView.autoSetDimension(.height, toSize: 700, relation: .greaterThanOrEqual)
    }
}

extension SearchMoviesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.all().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let contentForCell = SearchMoviesViewCell(index: indexPath.row, cell: cell)
        cell.contentView.addSubview(contentForCell)
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension SearchMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logic when cell is selected
    }
}

extension SearchMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 140)
    }
}
