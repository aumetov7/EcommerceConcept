//
//  UINavigationControllerExtension.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

// MARK: Back to previous screen by drag gesture

extension UINavigationController: UIGestureRecognizerDelegate {    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
