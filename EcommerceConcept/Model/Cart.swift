//
//  Cart.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 10/12/22.
//

import Foundation

struct Cart {
    var phone: [Phone]
    var totalCount: Int
    var totalPrice: Int
    var delivery: String
}

struct Phone: Identifiable {
    let id: Int
    let title: String
    let image: String
    let price: Int
    var count: Int
}

extension Cart {
    static var cart: Cart = Cart(phone: [], totalCount: 0, totalPrice: 0, delivery: "")
}
