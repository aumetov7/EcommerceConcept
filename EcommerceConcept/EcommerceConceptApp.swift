//
//  EcommerceConceptApp.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

@main
struct EcommerceConceptApp: App {
    @StateObject private var productVM = ProductViewModel(productService: ProductService(network: Network()))
    
    var body: some Scene {
        WindowGroup {
            switch productVM.state {
            case .failed, .notAvailable:
                LaunchScreen()
            case .successfull:
                ContentView(productVM: productVM)
            }
        }
    }
}
