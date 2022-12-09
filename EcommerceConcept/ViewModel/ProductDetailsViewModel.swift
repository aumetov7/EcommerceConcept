//
//  ProductDetailsViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class ProductDetailsViewModel: ObservableObject {
    @Published var product: ProductDetails = ProductDetails.products
    @Published var picture = Picture(picture: [:])
    
    private var productSubscriber = Set<AnyCancellable>()
    private var imageSubscriber = Set<AnyCancellable>()
    
    init() {
        getProduct(url: productDetailsURL)
    }
    
    func getProduct(url: URL) {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: ProductDetails.self, decoder: JSONDecoder())
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
                
                for images in product.basket {
                    self!.getProductImages(url: URL(string: images.images)!) { image in
                        self?.picture.picture[images.id] = image
                    }
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

extension ProductDetailsViewModel {
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
            .store(in: &imageSubscriber)
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

