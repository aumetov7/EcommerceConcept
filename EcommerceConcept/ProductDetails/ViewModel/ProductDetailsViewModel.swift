//
//  ProductDetailsViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import Foundation
import Combine

class ProductDetailsViewModel: ObservableObject {
    @Published var products: ProductDetails = ProductDetails.products
    @Published var state: DataState = .notAvailable
    @Published var hasError: Bool = false
    
    private var productDetailsService: ProductDetailsServiceProtocol
    private var subscriber = Set<AnyCancellable>()
    
    init(productDetailsService: ProductDetailsServiceProtocol) {
        self.productDetailsService = productDetailsService
        
        getProducts()
    }
    
    private func getProducts() {
        productDetailsService
            .getProduct()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("ProductDetails Error: \(error.localizedDescription)")
                    self?.state = .failed(error: error)
                default:
                    print("ProductDetails Completion Finished")
                    break
                }
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.state = .successfull
            }
            .store(in: &subscriber)
    }
}

extension ProductDetailsViewModel {
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
