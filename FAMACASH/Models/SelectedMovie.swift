//
//  SelectedMovie.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation


struct SelectedMovie: Codable {
    var title: String
    var runtime: Int
    var release_date: String
    var vote_average: Double
    var genres: [Genre]
    var overview: String
}


struct Genre: Codable, Equatable {
    var id: Int
    var name: String
}
