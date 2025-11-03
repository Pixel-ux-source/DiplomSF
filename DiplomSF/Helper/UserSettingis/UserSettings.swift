//
//  UserSettings.swift
//  DiplomSF
//
//  Created by Алексей on 24.10.2025.
//

import UIKit

final class UserSettings {
    private enum Keys {
        static let favorite = "favorite"
    }
    
    func setFavorites(isFavorite: Bool, id: Int64) {
        var favorites = UserDefaults.standard.dictionary(forKey: Keys.favorite) as? [String:Bool] ?? [:]
        favorites["\(id)"] = isFavorite
        UserDefaults.standard.set(favorites, forKey: Keys.favorite)
    }
    
    func isFavorite(_ id: Int64) -> Bool {
        guard let favorites = UserDefaults.standard.dictionary(forKey: Keys.favorite) as? [String:Bool] else { return false }
        return favorites["\(id)"] ?? false
    }

    func favoriteIds() -> [Int64] {
        guard let favorites = UserDefaults.standard.dictionary(forKey: Keys.favorite) as? [String:Bool] else { return [] }
        return favorites.compactMap { key, value in
            guard value == true, let id = Int64(key) else { return nil }
            return id
        }
    }
}
