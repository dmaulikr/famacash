//
//  Movies.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation


struct Movies: Codable {
    var results: [Movie]
}


struct Movie: Codable {
    var title: String
    var release_date: String
    var vote_average: Double
    var poster_path: String?
    var backdrop_path: String?
    var id: Int
}
