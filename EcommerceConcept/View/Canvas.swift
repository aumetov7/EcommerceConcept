//
//  Canvas.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct Canvas<Content : View> : View {
    @EnvironmentObject var uiState: UIStateViewModel
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .center)
    }
}
