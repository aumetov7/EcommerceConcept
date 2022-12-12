//
//  ProductViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: Product = Product.products
    @Published var state: DataState = .notAvailable
    @Published var hasError: Bool = false
    
    private var productService: ProductServiceProtocol
    private var subscriber = Set<AnyCancellable>()
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
        
        getProducts()
        setupErrorSubscriptions()
    }
    
    private func getProducts() {
        productService
            .getProduct()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.state = .successfull
            }
            .store(in: &subscriber)
    }
}

extension ProductViewModel {
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfull, .notAvailable:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}
