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
            case .notAvailable, .failed:
                LaunchScreen()
                    .alert(isPresented: $productVM.hasError) {
                        if case .failed(let error) = productVM.state {
                            return Alert(title: Text("Error"),
                                         message: Text(error.localizedDescription))
                            
                        } else {
                            return Alert(title: Text("Error"),
                                         message: Text("Something went wrong"))
                        }
                    }
            case .successfull:
                ContentView(productVM: productVM)
            }
        }
    }
}
