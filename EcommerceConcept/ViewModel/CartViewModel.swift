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
    
    let productDetailsVM = ProductDetailsViewModel()
    let uiState = UIStateViewModel()
    
    func addToCart(itemId: Int) {
        for item in productDetailsVM.product.basket {
            if itemId == item.id {
                let phone = Phone(id: itemId, title: item.title, image: productDetailsVM.picture.picture[item.id] ?? UIImage(), price: item.price, count: 1)
                let filteredCart = carts.phone.filter { $0.id == itemId }.count > 0
                
                if carts.phone.isEmpty {
                    carts.phone.append(phone)
                    print("Append")
                } else {
                    if filteredCart {
                        for index in 0 ..< carts.phone.count {
                            if carts.phone[index].id == itemId {
                                carts.phone[index].count += 1
                                print(carts.phone[index].count)
                            }
                        }
                    } else {
                        carts.phone.append(phone)
                    }
                }
                
                carts.totalCount += phone.count
                carts.totalPrice += phone.price
            }
        }
        
        carts.delivery = productDetailsVM.product.delivery
    }
    
    func decrease(itemId: Int) {
        for item in productDetailsVM.product.basket {
            if itemId == item.id {
                let filteredCart = carts.phone.filter { $0.id == itemId }.count > 0
                
                if filteredCart {
                    for index in 0 ..< carts.phone.count {
                        if carts.phone[index].id == itemId {
                            if carts.phone[index].count > 1 {
                                carts.phone[index].count -= 1
                                carts.totalPrice -= carts.phone[index].price
                                carts.totalCount -= 1
                                print(carts.phone[index].count)
                            } else if carts.phone[index].count == 1 {
                                carts.totalPrice -= carts.phone[index].price
                                carts.phone.remove(at: index)
                                carts.totalCount -= 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    func removeFromCart(itemId: Int) {
        for item in productDetailsVM.product.basket {
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
