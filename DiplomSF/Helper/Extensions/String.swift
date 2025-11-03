//
//  String.swift
//  DiplomSF
//
//  Created by Алексей on 28.10.2025.
//

import Foundation

extension String {
    func convertDate() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputDateFormatter.date(from: self) else { return self }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMMM yyyy"
        outputDateFormatter.locale = Locale(identifier: "ru_RU")
        
        let result = outputDateFormatter.string(from: date)
        return result
    }
}
