//
//  EcommerceConceptApp.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

@main
struct EcommerceConceptApp: App {
    @StateObject private var productVM = ProductViewModel()
    @StateObject private var productDetailsVM = ProductDetailsViewModel()
    
    var body: some Scene {
        WindowGroup {
            if !productVM.imageParseDone {
                LaunchScreen()
            } else {
                ContentView(productVM: productVM, productDetailsVM: productDetailsVM)
            }
        }
    }
}
