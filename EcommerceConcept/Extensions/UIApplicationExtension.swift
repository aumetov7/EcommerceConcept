//
//  UIApplicationExtension.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
