//
//  Model.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}

struct MenuItem: Codable, Hashable, Identifiable {
    let id = UUID()
    let title: String
    let price: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
        case image = "image"
    }
}
