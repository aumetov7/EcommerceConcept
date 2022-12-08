//
//  BrandViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import Foundation

class BrandViewModel: ObservableObject {
    @Published var brand = Brand.brands
    @Published var selectedBrand = Brand.brands.first!
    
    func selectBrand(brand: String) {
        self.selectedBrand = brand
    }
}
