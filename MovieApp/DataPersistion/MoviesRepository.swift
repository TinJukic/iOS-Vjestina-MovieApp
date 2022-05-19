//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by FIVE on 14.05.2022..
//

import Foundation
import UIKit
import CoreData

class MoviesRepository {
    var managedContext: NSManagedObjectContext! // omogucuje komunikaciju aplikacije i baze podataka
    var moviesDatabaseDataSource: MoviesDatabaseDataSource?
    var moviesNetworkDataSource: MoviesNetworkDataSource?
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
        
        self.moviesNetworkDataSource = MoviesNetworkDataSource()
        self.moviesDatabaseDataSource = MoviesDatabaseDataSource(managedContext: self.managedContext)
    }
}
