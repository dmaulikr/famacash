//
//  PlistService.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation

class PlistService {
    
    static func getPlistKey(key: PlistKey) -> String {
        guard let path = Bundle.main.path(forResource: "key-info", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path)
        else { return "" }
        
        switch key {
        case .apiKey:
            guard let apiKey = try? PropertyListDecoder().decode(APIKey.self, from: xml) else { return "" }
            return apiKey.api_key
        }
    }
}

enum PlistKey {
    case apiKey
}
