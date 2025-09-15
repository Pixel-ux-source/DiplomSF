//
//  BuilderProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

protocol BuilderProtocol {
    static func build(dataManager: PopularManager) -> vc
    associatedtype vc: UIViewController
}
