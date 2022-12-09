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
        // add to favourites action
        
        MainScreenView(productVM: productVM)
        
//        ProductDetailsView()
//            .environmentObject(UIStateViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(productVM: ProductViewModel())
        
        ContentView(productVM: ProductViewModel())
            .previewDevice("iPhone SE (3rd generation)")
    }
}
