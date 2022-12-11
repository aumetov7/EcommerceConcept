//
//  Endpoint.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static var product: Self {
        return Endpoint(path: "/654bd15e-b121-49ba-a588-960956b15175")
    }
    
    static var productDetails: Self {
        return Endpoint(path: "/53539a72-3c5f-4f30-bbb1-6ca10d42c149")
    }
}
