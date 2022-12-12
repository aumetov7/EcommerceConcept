//
//  ProductDetails.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import Foundation

struct ProductDetails: Decodable {
    let basket: [Basket]
    let delivery: String
    let id: String
    let total: Int
}

struct Basket: Decodable, Identifiable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}

extension ProductDetails {
    static var products = ProductDetails(basket: [], delivery: "", id: "", total: 0)
}
