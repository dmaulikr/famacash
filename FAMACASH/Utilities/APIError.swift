//
//  APIError.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation

enum APIError: Error {
    case unknownError
    case invalidURL
    case invalidResponse
    case invalidData
    case decodeError
    
    var localizedDescription : String{
        switch self {
        case .unknownError:
            return "error.unknown".localized
        case .invalidURL:
            return "error.invalidURL".localized
        case .invalidResponse:
            return "error.response".localized
        case .invalidData:
            return "error.data".localized
        case .decodeError:
            return "error.decode".localized
        }
    }
}
