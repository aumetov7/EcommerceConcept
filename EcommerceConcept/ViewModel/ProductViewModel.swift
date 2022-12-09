//
//  ProductViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import Foundation
import Combine
import UIKit

class ProductViewModel: ObservableObject {
//    @Published var product = Product.product
    @Published var product = Product(homeStore: [HomeStore(id: 1, isNew: true, title: "", subtitle: "", picture: "", isBuy: false)], bestSeller: [])
    @Published var hotSalesPicture = Picture(picture: [:])
    @Published var bestSellerPicture = Picture(picture: [:])
    @Published var imageParseDone = false
    
    private var productSubscriber = Set<AnyCancellable>()
    private var hotSalesSubscriber = Set<AnyCancellable>()
    private var bestSellerSubscriber = Set<AnyCancellable>()
    
    init() {
        getProduct(url: productURL)
    }
    
    func getProduct(url: URL) {
        let dispatchGroup = DispatchGroup()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: Product.self, decoder: decoder)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Product error: \(error.localizedDescription)")
                default:
                    print("Product done")
                    break
                }
            } receiveValue: { [weak self] product in
                self?.product = product
                
                dispatchGroup.enter()
                
                for images in product.homeStore {
                    self!.getProductImages(url: URL(string: images.picture)!) { image in
                        self?.hotSalesPicture.picture[images.id] = image
                    }
                }
                
                for images in product.bestSeller {
                    
                    self!.getProductImagess(url: URL(string: images.picture)!) { image in
                        self?.bestSellerPicture.picture[images.id] = image
                    }
                }
                
                dispatchGroup.leave()
                dispatchGroup.notify(queue: .main) {
                    self!.imageParseDone = true
                }
            }
            .store(in: &productSubscriber)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badURL)
        }
        
        return output.data
    }
}

// MARK: - Image Parses

extension ProductViewModel {
    func getProductImages(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(handleImageResponse)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Image Error: \(error.localizedDescription)")
                default:
                    print("Image done")
                    break
                }
            }, receiveValue: completionHandler)
            .store(in: &hotSalesSubscriber)
    }
    
    func getProductImagess(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(handleImageResponse)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Image Error: \(error.localizedDescription)")
                default:
                    print("Image done")
                    break
                }
            }, receiveValue: completionHandler)
            .store(in: &bestSellerSubscriber)
    }
    
    func handleImageResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        
        return image
    }
}
