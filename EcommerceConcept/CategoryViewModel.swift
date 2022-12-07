//
//  CategoryViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var category = Category()
    
    func selectItem(index: Int) {
        for stateIndex in 0 ..< category.states.count {
            category.states[stateIndex] = false
        }
        
        category.states[index] = true
    }
}
