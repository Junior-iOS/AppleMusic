//
//  Extension+Date.swift
//  Apple Music
//
//  Created by Junior Silva on 13/02/23.
//

import Foundation

extension String {
    func getFormattedDate() -> String {
        let date = self.components(separatedBy: "-")
        let dayAndtime = date[2].components(separatedBy: "T")
        let day = dayAndtime[0]
        let month = date[1]
        let year = date[0]
        return "\(day)/\(month)/\(year)"
    }
}
