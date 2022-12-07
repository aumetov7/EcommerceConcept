//
//  Product.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import Foundation

struct Product: Decodable {
    let homeStore: [HomeStore]
    let bestSeller: [BestSeller]
}

struct HomeStore: Decodable, Identifiable {
    let id: Int
    let isNew: Bool?
    let title: String
    let subtitle: String
    let picture: String
    let isBuy: Bool
}

struct BestSeller: Decodable, Identifiable {
    let id: Int
    let isFavorites: Bool
    let title: String
    let priceWithoutDiscount: Int
    let discountPrice: Int
    let picture: String
}

extension Product {
    static var product = Product(homeStore: [], bestSeller: [])
}
