//
//  Item.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct Item<Content: View>: View {
    @EnvironmentObject var uiState: UIStateViewModel
    
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var _id: Int
    var content: Content
    
    init(_id: Int,
         spacing: CGFloat,
         widthOfHiddenCards: CGFloat,
         cardHeight: CGFloat,
         @ViewBuilder _ content: () -> Content) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
        self.cardHeight = cardHeight
        self._id = _id
    }
    
    var body: some View {
        content
            .frame(width: cardWidth,
                   height: _id == uiState.activeCard ? cardHeight : cardHeight - 60,
                   alignment: .center)
    }
}
