//
//  ProductDetailsService.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import Foundation
import Combine

protocol ProductDetailsServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getProduct() -> AnyPublisher<ProductDetails, Error>
}

final class ProductDetailsService: ProductDetailsServiceProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getProduct() -> AnyPublisher<ProductDetails, Error> {
        let endpoint = Endpoint.productDetails
        
        return network.getData(with: endpoint.url, ProductDetails.self)
    }
}
