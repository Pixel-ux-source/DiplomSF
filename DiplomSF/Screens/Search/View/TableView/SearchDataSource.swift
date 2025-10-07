//
//  SearchDS.swift
//  DiplomSF
//
//  Created by Алексей on 30.09.2025.
//

import UIKit
import SDWebImage

final class SearchDataSource: NSObject, UITableViewDataSource {
    var searchModel: [SearchModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchFilmCell.id, for: indexPath) as? SearchFilmCell else { fatalError("DEQUEU_ERROR_CELL_SEARCH") }
        let object = searchModel[indexPath.row]

        let title = object.title
        let genre = object.overview
        let imagePath = object.posterPath
                
        cell.setUI(title: title, genre: genre)
        
        let image = cell.getPhotoImage()
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(imagePath)")

        image.sd_setImage(with: url)
        
        return cell
    }
    
    
}
