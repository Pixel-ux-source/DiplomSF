//
//  Double.swift
//  DiplomSF
//
//  Created by Алексей on 15.09.2025.
//

import Foundation

extension Double {
    func toString(decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
