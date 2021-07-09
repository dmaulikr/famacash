//
//  Ratings.swift
//  FAMACASH
//
//  Created by MD  on 08/07/21.
//

import Foundation


struct Ratings: Codable {
    var results: [Rating]
}


struct Rating: Codable {
    var author : String
    var author_details : AuthorDetails
    var content : String
    var created_at : String
    var id : String
    var updated_at : String
    var url : String
}

struct AuthorDetails: Codable, Equatable {

    var avatar_path : String
    var name : String
    var rating : Int?
    var username : String
}
