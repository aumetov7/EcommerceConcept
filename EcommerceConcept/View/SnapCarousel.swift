//
//  SnapCarousel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct SnapCarousel: View {
    @EnvironmentObject var uiState: UIStateViewModel
    
    @ObservedObject var product: ProductDetailsViewModel
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        return Canvas {
            /// TODO: find a way to avoid passing same arguments to Carousel and Item
            Carousel(numberOfItems: CGFloat(product.product.basket.count),
                     spacing: width * 0.08,
                     widthOfHiddenCards: width * 0.1) {
                ForEach(product.product.basket, id: \.self.id) { item in
                    Item(
                        _id: Int(item.id - 1),
                        spacing: width * 0.08,
                        widthOfHiddenCards: width * 0.1,
                        cardHeight: height * 0.42
                    ) {
                        Image(uiImage: product.picture.picture[item.id] ?? UIImage())
                            .resizedToFill(width: width * 0.7,
                                           height: height * 0.4)
                            .clipped()
                    }
                    .foregroundColor(Color.white)
                    .background(Color(.white))
                    .cornerRadius(20)
                    .shadow(color: Color(.black).opacity(0.2), radius: 4, x: 0, y: 4)
                    .transition(AnyTransition.slide)
                    .animation(.spring(), value: UUID())
                }
            }
        }
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarousel(product: ProductDetailsViewModel(), width: 414, height: 896)
            .environmentObject(UIStateViewModel())
    }
}
