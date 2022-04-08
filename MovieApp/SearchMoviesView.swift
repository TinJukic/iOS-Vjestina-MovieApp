//
//  SearchMoviesView.swift
//  MovieApp
//
//  Created by FIVE on 08.04.2022..
//

import Foundation
import UIKit
import PureLayout

// Kako dodati UITableView na moj view?
// Primjer prepisan iz skripte

class SearchMoviesView: UIView {
    var searched: String!
    var moviesUITableView: UITableView!
    let cellIdentifier = "cellId"
    var labela: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
//        self.searched = searched
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        moviesUITableView = UITableView(
            frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        )
        self.addSubview(moviesUITableView)
        
        moviesUITableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        moviesUITableView.dataSource = self
        
        labela = UILabel()
        labela.text = "Labela"
        self.addSubview(labela)
    }
    
    func addConstraints() {
        moviesUITableView.autoPinEdgesToSuperviewEdges()
        
        labela.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 0)
        labela.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
    }
}

extension SearchMoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration()
        cellConfig.text = "Row \(indexPath.row)"
        cellConfig.textProperties.color = .systemGreen
        
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
