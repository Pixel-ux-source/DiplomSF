//
//  BuilderProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

protocol BuilderProtocol {
    static func build(dataManager: CoreDataManager) -> vc
    associatedtype vc: UIViewController
}
