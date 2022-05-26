//
//  Movie+CoreDataProperties.swift
//  MovieApp
//
//  Created by FIVE on 25.05.2022..
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var genreIds: [Int64]?
    @NSManaged public var id: Int64
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Float
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Float
    @NSManaged public var voteCount: Int64
    @NSManaged public var genres: MovieGenre?
    @NSManaged public var groups: MovieGroup?

}

extension Movie : Identifiable {

}
