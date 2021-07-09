//
//  RatingsVM.swift
//  FAMACASH
//
//  Created by MD  on 08/07/21.
//

import Foundation

struct RatingsViewModel {
    private let selectedMovieRate: Rating
    
    init(_ selectedMovie: Rating) {
        self.selectedMovieRate = selectedMovie
    }
    
    var author: String {
        return self.selectedMovieRate.author
    }
    
    var content: String {
        return self.selectedMovieRate.content
    }
    
    var createdAt: String {
        let originalDateFormat = DateFormatter()
        originalDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = originalDateFormat.date(from: self.selectedMovieRate.created_at) else { return "" }
        
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "dd MMM yyyy"
        
        return newDateFormat.string(from: date)
        
    }
    
    var author_details: AuthorDetails {
        return self.selectedMovieRate.author_details
    }
    
    var id: String {
        return self.selectedMovieRate.id
    }
    
    var updatedAt: String {
        return self.selectedMovieRate.updated_at
    }
    
    var url: String {
        return self.selectedMovieRate.url
    }
    
    var rating: Int {
        let a = selectedMovieRate.author_details
        return a.rating ?? 0
    }
    
  
}
