//
//  Extension+Bundle.swift
//  Apple Music
//
//  Created by Junior Silva on 11/02/23.
//

import Foundation

extension Bundle {
    var appName: String {
        return self.object(forInfoDictionaryKey: "APP_NAME") as! String
    }
    
    var scheme: String {
        return self.object(forInfoDictionaryKey: "SCHEME") as! String
    }
    
    var host: String {
        return self.object(forInfoDictionaryKey: "HOST") as! String
    }
}
