//
//  MoviesNetworkDataSource.swift
//  MovieApp
//
//  Created by FIVE on 14.05.2022..
//

import Foundation
import UIKit

class MoviesNetworkDataSource {
    // zaduzena za dohvat filmova s mreze
    // preporuca se da iskoristimo network service iz prethodne zadace
    // nakon sto se podaci dohvate, potrebno ih je spremiti -> to se radi u MoviesDatabaseDataSource
    
    var networkService: NetworkService!
    
    init() { networkService = NetworkService() }
    
    var genres: Genres?
    var genreDescriptions: [GenreDescription]?
    func fetchGenres() -> [GenreDescription]? {
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
            DispatchQueue.main.async {
                self.genreDescriptions = self.genres?.genres ?? []
            }
            case .failure(let failure):
                print("failure in WhatsPopularView \(failure)")
            }
        }
        
        return genreDescriptions
    }
    
    func saveDataForMovie(movieDetails: MovieDetails) -> Movie {
        let movie = Movie()
        
        movie.originalTitle = movieDetails.originalTitle
        movie.originalLanguage = movieDetails.originalLanguage
        movie.adult = movieDetails.adult!
        movie.backdropPath = movieDetails.backdropPath
        movie.genreIds = movieDetails.genreIds as NSObject?
        movie.id = movie.id
        movie.voteCount = Int32(movieDetails.voteCount!)
        movie.voteAverage = movieDetails.voteAverage!
        movie.overview = movieDetails.overview
        movie.popularity = movieDetails.popularity!
        movie.posterPath = movieDetails.posterPath
        movie.releaseDate = movieDetails.releaseDate
        movie.title = movieDetails.title
        movie.video = movieDetails.video!
        movie.favorite = false // inicijalno niti jedan film nije u favoritima
        
        return movie
    }
    
    var whatsPopularMovieSearchResult: SearchResults?
    var whatsPopularMovieData: [Movie]?
    func fetchWhatsPopularData() -> [Movie]? {
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
                DispatchQueue.main.async {
                    // ovdje cu spremati podatke za filmove
                    self.whatsPopularMovieData = []
                    let results = self.whatsPopularMovieSearchResult?.results ?? []
                    let dataSize: Int = results.count
                    
                    for i in 0...dataSize {
                        self.whatsPopularMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
                    }
                }
            case .failure(let failure):
                print("failure in WhatsPopularView \(failure)")
            }
        }
        
        return whatsPopularMovieData
    }
    
    var trendingMovieSearchResult: SearchResults?
    var trendingMovieData: [Movie]?
    func fetchTrendingData() -> [Movie]? {
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/trending/movie/day?api_key=59afefdb9064ea17898a694d311e247e&page=1"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("trending/movie/day/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.trendingMovieSearchResult = success
                DispatchQueue.main.async {
                    // ovdje cu spremati podatke za filmove
                    self.trendingMovieData = []
                    let results = self.trendingMovieSearchResult?.results ?? []
                    let dataSize: Int = results.count
                    
                    for i in 0...dataSize {
                        self.trendingMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
                    }
                }
            case .failure(let failure):
                print("failure in TrendingView \(failure)")
            }
        }
        
        return self.trendingMovieData
    }
    
    var recommendedMovieSearchresult: SearchResults?
    var recommendedMovieData: [Movie]?
    func fetchRecommendedData() -> [Movie]? {
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/103/recommendations?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/103/recommendations/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.recommendedMovieSearchresult = success
                DispatchQueue.main.async {
                    // ovdje cu spremati podatke za filmove
                    self.recommendedMovieData = []
                    let results = self.recommendedMovieSearchresult?.results ?? []
                    let dataSize: Int = results.count
                    
                    for i in 0...dataSize {
                        self.recommendedMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
                    }
                }
            case .failure(let failure):
                print("failure in RecommendedView \(failure)")
            }
        }
        
        return self.recommendedMovieData
    }
    
    var topRatedMovieSearchResult: SearchResults?
    var topRatedMovieData: [Movie]?
    func fetchTopRatedData() -> [Movie]? {
        let popularMoviesUrlRequestString = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=59afefdb9064ea17898a694d311e247e"
        guard let popularMoviesUrl = URL(string: popularMoviesUrlRequestString) else { return nil }
        var popularMoviesUrlRequest = URLRequest(url: popularMoviesUrl)
        popularMoviesUrlRequest.httpMethod = "GET"
        popularMoviesUrlRequest.setValue("movie/top_rated/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(popularMoviesUrlRequest) { (result: Result<SearchResults, RequestError>) in
            switch result {
            case .success(let success):
                self.topRatedMovieSearchResult = success
                DispatchQueue.main.async {
                    // ovdje cu spremati podatke za filmove
                    self.topRatedMovieData = []
                    let results = self.topRatedMovieSearchResult?.results ?? []
                    let dataSize: Int = results.count
                    
                    for i in 0...dataSize {
                        self.topRatedMovieData?[i] = self.saveDataForMovie(movieDetails: results[i])
                    }
                }
            case .failure(let failure):
                print("failure in TopRatedView \(failure)")
            }
        }
        
        return topRatedMovieData
    }
}
