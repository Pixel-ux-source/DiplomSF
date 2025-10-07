//
//  SearchConfiguration.swift
//  DiplomSF
//
//  Created by Алексей on 25.09.2025.
//

import UIKit

struct SearchConfiguration {
    static func make(for vc: UISearchResultsUpdating) -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        let textField = searchBar.searchTextField

        if let iconView = textField.leftView as? UIImageView {
            iconView.tintColor = UIColor.gray.withAlphaComponent(0.5)
        }
        
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Какой фильм посмотрим?", attributes: [
            .foregroundColor: UIColor.gray.withAlphaComponent(0.5),
            .font: UIFont.systemFont(ofSize: 17, weight: .medium),
            .kern: -0.41
        ])
        
        searchController.searchBar.tintColor = .red

        textField.borderStyle = .none
        textField.layer.cornerRadius = 0
        textField.layer.masksToBounds = true
        textField.backgroundColor = .secondarySystemBackground
        
        searchController.searchResultsUpdater = vc
        searchController.obscuresBackgroundDuringPresentation = false
        
        return searchController
    }
}
