//
//  Movie+CoreDataProperties.swift
//  MovieApp
//
//  Created by FIVE on 26.05.2022..
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
    @NSManaged public var genres: NSSet?
    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for genres
extension Movie {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: MovieGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: MovieGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for groups
extension Movie {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: MovieGroup)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: MovieGroup)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}

extension Movie : Identifiable {

}
