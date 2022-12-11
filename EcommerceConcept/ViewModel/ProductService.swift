//
//  ProductService.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import Foundation
import Combine

protocol ProductServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getProduct() -> AnyPublisher<Product, Error>
}

final class ProductService: ProductServiceProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getProduct() -> AnyPublisher<Product, Error> {
        let endpoint = Endpoint.product
        
        return network.getData(with: endpoint.url, Product.self)
    }
}
