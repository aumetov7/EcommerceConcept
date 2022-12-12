//
//  CartViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 10/12/22.
//

import Foundation
import UIKit

class CartViewModel: ObservableObject {
    @Published var carts: Cart = Cart.cart
    
    let productDetails: ProductDetails
    
    init(productDetails: ProductDetails) {
        self.productDetails = productDetails
    }
    
    func addToCart(itemId: Int) {
        for item in productDetails.basket {
            if itemId == item.id {
                let phone = Phone(id: itemId,
                                  title: item.title,
                                  image: item.images,
                                  price: item.price,
                                  count: 1)
                let filteredCart = carts.phone.filter { $0.id == itemId }.count > 0
                
                if carts.phone.isEmpty {
                    carts.phone.append(phone)
                } else {
                    if filteredCart {
                        for index in 0 ..< carts.phone.count {
                            if carts.phone[index].id == itemId {
                                carts.phone[index].count += 1
                            }
                        }
                    } else {
                        carts.phone.append(phone)
                    }
                }
                
                carts.totalCount += phone.count
                carts.totalPrice += phone.price * phone.count
            }
        }
        
        carts.delivery = productDetails.delivery
    }
    
    func decrease(itemId: Int) {
        for item in productDetails.basket {
            if itemId == item.id {
                let filteredCart = carts.phone.filter { $0.id == itemId }.count > 0
                
                if filteredCart {
                    for index in 0 ..< carts.phone.count {
                        if carts.phone[index].id == itemId {
                            if carts.phone[index].count > 1 {
                                carts.phone[index].count -= 1
                                carts.totalPrice -= carts.phone[index].price
                                carts.totalCount -= 1
                            } else if carts.phone[index].count == 1 {
                                carts.totalPrice -= carts.phone[index].price
                                carts.phone.remove(at: index)
                                carts.totalCount -= 1
                                
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    func removeFromCart(itemId: Int) {
        for item in productDetails.basket {
            if itemId == item.id {
                let filteredCart = carts.phone.filter { $0.id == itemId }.count > 0
                
                if filteredCart {
                    for index in 0 ..< carts.phone.count {
                        if carts.phone[index].id == itemId {
                            carts.totalPrice -= carts.phone[index].count * carts.phone[index].price
                            carts.totalCount -= carts.phone[index].count
                            carts.phone.remove(at: index)
                            
                            break
                        }
                    }
                }
            }
        }
    }
}
