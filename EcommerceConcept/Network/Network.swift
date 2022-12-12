//
//  Network.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    func getData<T>(with url: URL, _ type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}

final class Network: NetworkProtocol {
    func getData<T>(with url: URL, _ type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(self.handleOutput)
            .decode(type: type.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

// MARK: - Network Output Handler

extension Network {
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badURL)
        }
        
        return output.data
    }
}
