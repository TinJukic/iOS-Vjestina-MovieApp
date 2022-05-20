//
//  MoviesDatabaseDataSource.swift
//  MovieApp
//
//  Created by FIVE on 14.05.2022..
//

import Foundation
import UIKit
import CoreData

class MoviesDatabaseDataSource {
    // zaduzena za dohvacanje i spremanje filmova u bazu podataka
    // prilikom spremanja filmova u bazu podataka, trebam provjeriti je li film vec u bazi
        // mogu pozvati metodu za dohvat filma po ID-u (vraca listu filmova)
            // ako ta metoda vrati nil -> film nije u bazi
            // inace -> film je u bazi -> spremi ga kao novi film
    
    var managedContext: NSManagedObjectContext!
    
    init(managedContext: NSManagedObjectContext) { self.managedContext = managedContext }
    
    // dohvacanje svih filmova iz memorije uredjaja poredanih abecednim redom po nazivu filma
    // kategoriju filma dobivam iz movie group u bazi - KAKO?
    func fetchAllMovies() -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let nameSort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [nameSort]
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("Error \(error) : Info: \(error.userInfo)")
            return []
        }
    }
    
    // dohvacanje tocno odredjenog filma (po id-u)
    func fetchMovie(withId id: UUID) -> Movie? {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            return try managedContext.fetch(request).first
        } catch let error as NSError {
            print("Error \(error) : Info: \(error.userInfo)")
            return nil
        }
    }
    
    func fetchMoviesFromCategory(withCategory genre: GenreDescription) -> [Movie] {
        return []
    }
    
    func fetchMoviesByNameSearch(withName title: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS %@", "\(title)")
        request.predicate = predicate
        
        let nameSort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [nameSort]
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("Error \(error) occured in fetchMoviesByNameSearch with info: \(error.userInfo)")
            return []
        }
    }
    
    // azuriranje vrijednosti za favorite svojstvo filma na pritisak gumba
    func updateFavorite(withId id: UUID) {
        let movie = fetchMovie(withId: id)
        
        if(movie?.favorite == true) {
            movie?.favorite = false
        } else {
            movie?.favorite = true
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error \(error) occured in updateFavorite with info: \(error.userInfo)")
        }
    }
    
    // potrebno je jos moci dohvatiti sve favorite filmove iz baze za prikaz na favorites screenu
    // bit ce sortirani abecednim redom
    func fetchFavorites() -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "favorite = %@", true)
        request.predicate = predicate
        
        let nameSort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [nameSort]
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("Error \(error) occured in fetchFavorites with info: \(error.userInfo)")
            return []
        }
    }
    
    // potrebno je napraviti spremanje filmova za svaki zanr posebno
    // vise zanrova ?
    // svaki film koji dohvatim ima i listu zanrova kojima pripada
    
    // potrebno je dohvacati i zanrove
    
    // spremanje dohvacenih filmova u bazu podataka
    // buduci da filmove dohvacam po grupama, odmah znam kojoj grupi film pripada
    
    // dohvati sve zanrove koje imas u bazi podataka
    var genreDescriptions: [GenreDescription]?
    func fetchAllGenres() -> [GenreDescription] {
        return []
    }
    
    // dohvati genre po njegovom ID-u
    func fetchGenre(withId id: UUID) -> GenreDescription? {
        return nil
    }
    
    // podatke dohvacam s interneta u MoviesRepository i dalje ih prosljedjujem ovim metodama
    // metode ispod pozivam samo jednom, prilikom pokretanja aplikacije, dalje se sve radi preko baze podataka
    func saveWhatsPopularMovieData(whatsPopularSearchResults: SearchResults?) {
        // vezu izmedju pojedinih filmova i grupa pravim na nacin da filmu dodijelim grupu koja mu treba
        // sto sve trebam staviti u grupu ?
        
        let group = MovieGroup(context: managedContext)
        group.name = "Whats popular"
        
        // dalje moram dohvatiti sve filmove koji odgovaraju ovom pozivu i postaviti vezu izmedju njih i grupe kojoj pripadaju
        // uvijek moram provjeriti postoji li taj film vec u bazi podataka
        do {
            try whatsPopularSearchResults?.results.forEach({ searchResult in
                let id = searchResult.id! as! UUID
                let movieInDatabase = fetchMovie(withId: id)
                
                if(movieInDatabase == nil) {
                    group.addToMovies(saveMovie(movieDetails: searchResult))
                } else {
                    updateMovie(movieInDatabase: movieInDatabase!, fetchedMovie: searchResult)
                }
                
                // sada je potrebno svaki film spremiti u bazu podataka
                try managedContext.save()
            })
        } catch let error as NSError {
            print("Error \(error) occured in saveTopRatedMovieData with info: \(error.userInfo)")
        }
    }
    
    func saveTrendingMovieData(trendingSearchResults: SearchResults?) {
        let group = MovieGroup(context: managedContext)
        group.name = "Trending"
        
        // uvijek moram provjeriti postoji li taj film vec u bazi podataka
        do {
            try trendingSearchResults?.results.forEach({ searchResult in
                let id = searchResult.id! as! UUID
                let movieInDatabase = fetchMovie(withId: id)
                
                if(movieInDatabase == nil) {
                    group.addToMovies(saveMovie(movieDetails: searchResult))
                } else {
                    updateMovie(movieInDatabase: movieInDatabase!, fetchedMovie: searchResult)
                }
                
                // sada je potrebno svaki film spremiti u bazu podataka
                try managedContext.save()
            })
        } catch let error as NSError {
            print("Error \(error) occured in saveTopRatedMovieData with info: \(error.userInfo)")
        }
    }
    
    func saveRecomendedMovieData(recomendedSearchResults: SearchResults?) {
        let group = MovieGroup(context: managedContext)
        group.name = "Recomended"
        
        // uvijek moram provjeriti postoji li taj film vec u bazi podataka
        do {
            try recomendedSearchResults?.results.forEach({ searchResult in
                let id = searchResult.id! as! UUID
                let movieInDatabase = fetchMovie(withId: id)
                
                if(movieInDatabase == nil) {
                    group.addToMovies(saveMovie(movieDetails: searchResult))
                } else {
                    updateMovie(movieInDatabase: movieInDatabase!, fetchedMovie: searchResult)
                }
                
                // sada je potrebno svaki film spremiti u bazu podataka
                try managedContext.save()
            })
        } catch let error as NSError {
            print("Error \(error) occured in saveTopRatedMovieData with info: \(error.userInfo)")
        }
    }
    
    func saveTopRatedMovieData(topRatedSearchResults: SearchResults?) {
        let group = MovieGroup(context: managedContext)
        group.name = "Top rated"
        
        // uvijek moram provjeriti postoji li taj film vec u bazi podataka
        do {
            try topRatedSearchResults?.results.forEach({ searchResult in
                let id = searchResult.id! as! UUID
                let movieInDatabase = fetchMovie(withId: id)
                
                if(movieInDatabase == nil) {
                    group.addToMovies(saveMovie(movieDetails: searchResult))
                } else {
                    updateMovie(movieInDatabase: movieInDatabase!, fetchedMovie: searchResult)
                }
                
                // sada je potrebno svaki film spremiti u bazu podataka
                try managedContext.save()
            })
        } catch let error as NSError {
            print("Error \(error) occured in saveTopRatedMovieData with info: \(error.userInfo)")
        }
    }
    
    func updateMovie(movieInDatabase: Movie?, fetchedMovie: MovieDetails) {
        if(movieInDatabase != nil) {
            // ne trebam mijenjati favorite oznaku!
            movieInDatabase!.title = fetchedMovie.title
            movieInDatabase!.originalTitle = fetchedMovie.originalTitle
            movieInDatabase!.adult = fetchedMovie.adult!
            movieInDatabase!.voteCount = Int32(fetchedMovie.voteCount!)
            movieInDatabase!.voteAverage = fetchedMovie.voteAverage!
            movieInDatabase!.backdropPath = fetchedMovie.backdropPath
            movieInDatabase!.genreIds = fetchedMovie.genreIds as NSObject?
            movieInDatabase!.originalLanguage = fetchedMovie.originalLanguage
            movieInDatabase!.overview = fetchedMovie.overview
            movieInDatabase!.popularity = fetchedMovie.popularity!
            movieInDatabase!.posterPath = fetchedMovie.posterPath
            movieInDatabase!.releaseDate = fetchedMovie.releaseDate
            movieInDatabase!.video = fetchedMovie.video!
        }
    }
    
    func saveMovie(movieDetails: MovieDetails) -> Movie {
        let movie = Movie()
        
        movie.originalTitle = movieDetails.originalTitle
        movie.originalLanguage = movieDetails.originalLanguage
        movie.adult = movieDetails.adult!
        movie.backdropPath = movieDetails.backdropPath
        movie.genreIds = movieDetails.genreIds as NSObject?
        movie.id = movieDetails.id as! UUID
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
}
