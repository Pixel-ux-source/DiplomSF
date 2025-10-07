//
//  SearchTable.swift
//  DiplomSF
//
//  Created by Алексей on 30.09.2025.
//

import UIKit

final class SearchTable: UITableView {
    // MARK: – Initializate
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        register(SearchFilmCell.self, forCellReuseIdentifier: SearchFilmCell.id)
    }
    
}
