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
    
    func appLaunch() {
        // dohvaca podatke i sprema ih (azurira)
        print("Evo ja pokusavam dohvatiti i spremiti podatke...")
        
        whatsPopularData()
        trendingData()
        recomendedData()
        topRatedData()
    }
    
    func whatsPopularData() {
        let whatsPopularMovieData = moviesNetworkDataSource?.whatsPopularMovieSearchResult
        moviesDatabaseDataSource?.saveWhatsPopularMovieData(whatsPopularSearchResults: whatsPopularMovieData)
    }
    
    func trendingData() {
        let trendingMovieData = moviesNetworkDataSource?.trendingMovieSearchResult
        moviesDatabaseDataSource?.saveTrendingMovieData(trendingSearchResults: trendingMovieData)
    }
    
    func recomendedData() {
        let recomendedMovieData = moviesNetworkDataSource?.recommendedMovieSearchresult
        moviesDatabaseDataSource?.saveRecomendedMovieData(recomendedSearchResults: recomendedMovieData)
    }
    
    func topRatedData() {
        let topRatedMovieData = moviesNetworkDataSource?.topRatedMovieSearchResult
        moviesDatabaseDataSource?.saveTopRatedMovieData(topRatedSearchResults: topRatedMovieData)
    }
}
