//
//  SearchDelegate.swift
//  DiplomSF
//
//  Created by Алексей on 30.09.2025.
//

import UIKit

final class SearchDelegate: NSObject, UITableViewDelegate {
    var coordinator: CoordinatorProtocol!
    var searchModel: [SearchModel] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = searchModel[indexPath.row]
        coordinator.openDetailScreen(for: object)
    }
}
