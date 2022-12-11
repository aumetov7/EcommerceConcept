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
    static var products = Product(homeStore: [HomeStore(id: 0,
                                                        isNew: true,
                                                        title: "",
                                                        subtitle: "",
                                                        picture: "",
                                                        isBuy: true)],
                                  bestSeller: [BestSeller(id: 0,
                                                          isFavorites: true,
                                                          title: "",
                                                          priceWithoutDiscount: 0,
                                                          discountPrice: 0,
                                                          picture: "")])
}
