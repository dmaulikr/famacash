//
//  Languages.swift
//  FAMACASH
//
//  Created by MD on 08/07/21.
//

import Foundation

extension String {
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: Keys.APP_LANGUAGE) {} else {
            // we set a default, just in case
            UserDefaults.standard.set("en", forKey: Keys.APP_LANGUAGE)
            UserDefaults.standard.synchronize()
        }
        
        let lang = UserDefaults.standard.string(forKey: Keys.APP_LANGUAGE)
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }

        return NSLocalizedString(self, tableName: nil, bundle: Bundle(), value: "", comment: "")
    }
}
