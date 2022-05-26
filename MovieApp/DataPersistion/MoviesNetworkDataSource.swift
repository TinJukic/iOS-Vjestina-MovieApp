//
//  MoviesNetworkDataSource.swift
//  MovieApp
//
//  Created by FIVE on 14.05.2022..
//

import Foundation
import UIKit
import CoreData

class MoviesNetworkDataSource {
    // zaduzena za dohvat filmova s mreze
    // preporuca se da iskoristimo network service iz prethodne zadace
    // nakon sto se podaci dohvate, potrebno ih je spremiti -> to se radi u MoviesDatabaseDataSource
    
    // za svaki film moram prvo provjeriti je li vec spremljen u bazu podataka
        // ako nije, spremam ga
        // ako je, potrebno je azurirati dohvacene vrijednosti -> ocuvana oznaka favorite
    
    // ova klasa samo radi dohvat s interneta -> prosljedjuje sto je dohvaceno s interneta dalje aplikaciji
    
    var networkService: NetworkService!
    var moviesDatabaseDatasource: MoviesDatabaseDataSource!
    var managedContext: NSManagedObjectContext!
    
    init(managedContext: NSManagedObjectContext) {
        networkService = NetworkService()
        self.managedContext = managedContext
        self.moviesDatabaseDatasource = MoviesDatabaseDataSource(managedContext: managedContext)
    }
    
    var genres: Genres?
    func getGenres() -> Genres? {
        // dohvat podataka za genres
        let genresUrlRequestString = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=59afefdb9064ea17898a694d311e247e"
        guard let genresUrl = URL(string: genresUrlRequestString) else { return nil }
        var genresUrlRequest = URLRequest(url: genresUrl)
        genresUrlRequest.httpMethod = "GET"
        genresUrlRequest.setValue("genre/movie/list/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(genresUrlRequest) { (result: Result<Genres, RequestError>) in
        switch result {
            case .success(let value):
                self.genres = value
            case .failure(let failure):
                print("failure in WhatsPopularView \(failure)")
            }
        }
        
        return self.genres
    }
    
    var whatsPopularMovieSearchResult: SearchResults?
    func getWhatsPopularData() -> SearchResults? {
        // dohvacanje podataka s interneta i spremanje informacija o pojedinom filmu u Movie
        // vracam listu koja sadrzi sve filmove s njihovim podacima
        
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/popular/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.whatsPopularMovieSearchResult = success
                self.moviesDatabaseDatasource.saveWhatsPopularMovieData(whatsPopularSearchResults: self.whatsPopularMovieSearchResult)
            case .failure(let failure):
                print("failure in WhatsPopularView \(failure)")
            }
        }
        
        return self.whatsPopularMovieSearchResult
    }
    
    var trendingMovieSearchResult: SearchResults?
    func getTrendingData() -> SearchResults? {
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/trending/movie/day?api_key=59afefdb9064ea17898a694d311e247e&page=1"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("trending/movie/day/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.trendingMovieSearchResult = success
//                DispatchQueue.main.async {
//                    // ovdje cu spremati podatke za filmove
//                    self.trendingMovieData = []
//                    let results = self.trendingMovieSearchResult?.results ?? []
//                    let dataSize: Int = results.count
//
//                    for i in 0...dataSize {
//                        self.trendingMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
//                    }
//                }
            case .failure(let failure):
                print("failure in TrendingView \(failure)")
            }
        }
        
        return self.trendingMovieSearchResult
    }
    
    var recommendedMovieSearchresult: SearchResults?
    func getRecommendedData() -> SearchResults? {
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/103/recommendations?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/103/recommendations/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.recommendedMovieSearchresult = success
//                DispatchQueue.main.async {
//                    // ovdje cu spremati podatke za filmove
//                    self.recommendedMovieData = []
//                    let results = self.recommendedMovieSearchresult?.results ?? []
//                    let dataSize: Int = results.count
//
//                    for i in 0...dataSize {
//                        self.recommendedMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
//                    }
//                }
            case .failure(let failure):
                print("failure in RecommendedView \(failure)")
            }
        }
        
        return self.recommendedMovieSearchresult
    }
    
    var topRatedMovieSearchResult: SearchResults?
    func getTopRatedData() -> SearchResults? {
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/top_rated/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.topRatedMovieSearchResult = success
//                DispatchQueue.main.async {
//                    // ovdje cu spremati podatke za filmove
//                    self.topRatedMovieData = []
//                    let results = self.topRatedMovieSearchResult?.results ?? []
//                    let dataSize: Int = results.count
//
//                    for i in 0...dataSize {
//                        self.topRatedMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
//                    }
//                }
            case .failure(let failure):
                print("failure in TopRatedView \(failure)")
            }
        }
        
        return self.topRatedMovieSearchResult
    }
}
