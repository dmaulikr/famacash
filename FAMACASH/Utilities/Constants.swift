//
//  Constants.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import UIKit

let pageSize = 10

struct Keys {
    static let API_KEY = "api_key"
    static let LANGUAGE = "language"
    static let ORIENTATION = "orientation"
    static let APP_LANGUAGE = "app_lang"
}

struct ApiURL {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let selectedMovie = baseURL
    static let image = "https://image.tmdb.org/t/p/"
    static let youtubeURL = "https://www.youtube.com/embed/"
}

struct Images {
    static let emptyImage = UIImage(named: "empty_image")
    static let back = UIImageView(image: UIImage(named: "back_white"))
}

enum MovieType {
    case nowPlaying
    case topRated
    case popular
    case upcoming
    
    var value : String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .topRated:
            return "top_rated"
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        }
    }
}
