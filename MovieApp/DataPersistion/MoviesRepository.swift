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
        
        self.moviesNetworkDataSource = MoviesNetworkDataSource(managedContext: self.managedContext)
        self.moviesDatabaseDataSource = MoviesDatabaseDataSource(managedContext: self.managedContext)
    }
    
    func appLaunch() {
        // dohvaca podatke i sprema ih (azurira)
        print("Evo ja pokusavam dohvatiti i spremiti podatke...")
        
        genres()
        whatsPopularData()
        trendingData()
        recomendedData()
        topRatedData()
        
        print("Gotov sam")
    }
    
    func genres() {
        moviesNetworkDataSource?.getGenres()
    }
    
    func whatsPopularData() {
        moviesNetworkDataSource?.getWhatsPopularData()
    }
    
    func trendingData() {
        moviesNetworkDataSource?.getTrendingData()
    }
    
    func recomendedData() {
        moviesNetworkDataSource?.getRecommendedData()
    }
    
    func topRatedData() {
        moviesNetworkDataSource?.getTopRatedData()
    }
}
