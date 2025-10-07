//
//  CoordinatorProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start()
    func openDetailScreen(for model: ModelsProtocol)
}
