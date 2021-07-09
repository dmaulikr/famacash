//
//  Protocols.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation

protocol LanguageDelegate{
    func chooseLanguage()
}

protocol MovieSegmentDelegate {
    func loadMovie(movieType: MovieType)
}
