//
//  ContentView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var productVM: ProductViewModel
    @ObservedObject var productDetailsVM: ProductDetailsViewModel
    
    var body: some View {
        // add to favourites action
        
        MainScreenView(productVM: productVM, productDetailsVM: productDetailsVM)
            .environmentObject(CartViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(productVM: ProductViewModel(), productDetailsVM: ProductDetailsViewModel())
    }
}
