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
    var managedContext: NSManagedObjectContext!
    
    init(managedContext: NSManagedObjectContext) { self.managedContext = managedContext }
    
    // dohvacanje svih filmova iz memorije uredjaja poredanih abecednim redom po nazivu filma
    // kategoriju filma dobivam iz movie group u bazi - KAKO?
    func fetchMovies() -> [Movie] {
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
    
    // potrebno je napraviti spremanje filmova za svaki zanr posebno
    // vise zanrova ?
    // svaki film koji dohvatim ima i listu zanrova kojima pripada
    
    // potrebno je dohvacati i zanrove
    
    // spremanje dohvacenih filmova u bazu podataka
    // buduci da filmove dohvacam po zanrovima, odmah znam kojem zanru film pripada
    var genreDescriptions: [GenreDescription]?
    
    var whatsPopularMovieData: [Movie]?
    func saveWhatsPopularMovieData() {
        let fetch: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        
    }
    
    var trendingMovieData: [Movie]?
    func saveTrendingMovieData() {
        
    }
    
    var recomendedMovieData: [Movie]?
    func saveRecomendedMovieData() {
        
    }
    
    var topRatedMovieData: [Movie]?
    func saveTopRatedMovieData() {
        
    }
}
