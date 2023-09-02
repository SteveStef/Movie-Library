//
//  Movie.swift
//  MovieLibrary2.0
//
//  Created by Stephen Stefanatos on 7/28/23.
//

import Foundation

struct CastMember: Identifiable {
    let id: String
    var name: String
}

struct Movie: Hashable, Identifiable, Equatable {
    let id: String
    var title: String
    var picture: String
    var overview: String
    var cast: [CastMember]
    var year: Int
    var advisedMinimumAudienceAge: Int
    var imdbRating: Int
    var imdbVoteCount: Int
    var tmdbRating: Int
    var youtubeTrailerVideoLink: String
    var runtime: Int
    var streamingInfo: [String]
    var seasons: Int
    var genres: [String]
    var rating: Float // Add rating for each movie
    var isNew: Bool // Add a property to indicate if the movie is new
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id // You can choose other properties for comparison if needed
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Combine the id property to generate a hash value
    }
}
