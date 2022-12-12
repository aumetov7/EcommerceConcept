//
//  Carousel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct Carousel<Items: View> : View {
    @EnvironmentObject var uiState: UIStateViewModel
    
    @State private var screenDrag: Float = 0
    
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    init(numberOfItems: CGFloat,
         spacing: CGFloat,
         widthOfHiddenCards: CGFloat,
         @ViewBuilder _ items: () -> Items) {
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
    }
    
    // MARK: Snap Carousel main logic
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(uiState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(uiState.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + uiState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset),
                y: 0)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    uiState.screenDrag = Float(value.translation.width)
                })
                .onEnded({ value in
                    uiState.screenDrag = 0
                    
                    if (value.translation.width < -50 && CGFloat(uiState.activeCard) < numberOfItems - 1) {
                        uiState.activeCard = uiState.activeCard + 1
                    }
                    
                    if (value.translation.width > 50 && CGFloat(uiState.activeCard) > 0) {
                        uiState.activeCard = uiState.activeCard - 1
                    }
                })
        )
    }
}
