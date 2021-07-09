//
//  Trailers.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation


struct Trailers: Codable {
    var results: [Trailer]
}

struct Trailer: Codable {
    var id: String
    var key: String
}
