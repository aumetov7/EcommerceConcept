//
//  PriceViewModel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import Foundation
import UIKit

class PriceViewModel: ObservableObject {
    @Published var minValue: CGFloat = 0
    @Published var maxValue: CGFloat = 10000
    @Published var minLocation: CGFloat = 0
    @Published var maxLocation: CGFloat = UIScreen.main.bounds.width * 0.75
    
    func getMinLocation() -> CGFloat {
        return minValue / maxValue
    }
    
    func getMaxLocation() -> CGFloat {
        return maxValue / maxValue
    }
}
