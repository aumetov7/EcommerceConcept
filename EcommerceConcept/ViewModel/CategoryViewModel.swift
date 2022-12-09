//
//  CategoryViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var category = Category()
    @Published var buttonSelected = 0
}
