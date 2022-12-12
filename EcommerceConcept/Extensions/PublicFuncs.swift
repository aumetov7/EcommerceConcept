//
//  PublicFuncs.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import Foundation

// MARK: GCFloat to String for Price Slider

func getValue(val: CGFloat) -> String {
    return String(format: "%.0f", val.rounded())
}
