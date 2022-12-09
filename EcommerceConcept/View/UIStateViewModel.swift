//
//  UIStateViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import Foundation

public class UIStateViewModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}
