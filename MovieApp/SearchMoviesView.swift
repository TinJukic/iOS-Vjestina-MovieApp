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

// Kako dodati UITableView na moj view?
// Primjer prepisan iz skripte

class SearchMoviesView: UIView {
    var searched: String!
//    var moviesUITableView: UITableView!
    var moviesCollectionView: UICollectionView!
    let cellIdentifier = "cellId"
    var labela: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBrown
//        self.searched = searched
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
//        moviesUITableView = UITableView(
//            frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        )
//        self.addSubview(moviesUITableView)
//
//        moviesUITableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
//        moviesUITableView.dataSource = self
        
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
    
    func addConstraints() {//        Opet isti problem -> moviesUITableView nema height
//        Kako ga postaviti????
//        moviesUITableView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
//        moviesUITableView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
//        moviesUITableView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
//        moviesUITableView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
//        moviesUITableView.autoSetDimension(.height, toSize: 700, relation: .greaterThanOrEqual)
        
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 0)
        moviesCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        moviesCollectionView.autoSetDimension(.height, toSize: 700, relation: .greaterThanOrEqual)
    }
}

//extension SearchMoviesView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Movies.all().count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//
////        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration()
////        cellConfig.text = "Row \(indexPath.row)"
////        cellConfig.textProperties.color = .systemGreen
////
////        cell.contentConfiguration = cellConfig
//
//        let contentForCell = SearchMoviesViewCell(index: indexPath.row)
//        cell.contentView.addSubview(contentForCell)
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//}

extension SearchMoviesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.all().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .white
        let contentForCell = SearchMoviesViewCell(index: indexPath.row)
        cell.contentView.addSubview(contentForCell)
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
        return CGSize(width: 325, height: 140)
    }
}
