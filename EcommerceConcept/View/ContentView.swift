//
//  ContentView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var productVM: ProductViewModel
    
    var body: some View {
        MainScreenView(productVM: productVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(productVM: ProductViewModel(productService: ProductService(network: Network())))
    }
}
