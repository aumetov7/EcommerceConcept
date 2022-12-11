//
//  SnapCarouselItem.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

struct SnapCarouselItem: View {
    @EnvironmentObject var uiState: UIStateViewModel
    
    @Binding var itemId: Int
    @Binding var title: String
    @Binding var price: Int
    
    let basket: Basket
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            Item(
                _id: Int(basket.id - 1),
                spacing: width * 0.07,
                widthOfHiddenCards: width * 0.1,
                cardHeight: height * 0.42
            ) {
                AsyncImage(url: URL(string: basket.images)) { image in
                    image
                        .resizedToFill(width: basket.id - 1 == uiState.activeCard ? width * 0.7 : width * 0.6,
                                       height: basket.id - 1 == uiState.activeCard ? height * 0.4 : height * 0.3)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }

            }
            .foregroundColor(Color.white)
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(color: Color(.black).opacity(0.2), radius: 4, x: 0, y: 4)
            .transition(AnyTransition.slide)
            .animation(.spring(), value: UUID())
            .onAppear {
                if uiState.activeCard == basket.id - 1 {
                    itemId = basket.id
                    title = basket.title
                    price = basket.price
                }
            }
            .onChange(of: uiState.activeCard) { newValue in
                if uiState.activeCard == basket.id - 1 {
                    itemId = basket.id
                    title = basket.title
                    price = basket.price
                }
            }
        }
    }
}

struct SnapCarouselItem_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarouselItem(itemId: .constant(1),
                         title: .constant(""),
                         price: .constant(0),
                         basket: Basket(id: 1,
                                        images: "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
                                        price: 1500,
                                        title: "Galaxy Note 20 Ultra"),
                         width: 414,
                         height: 896)
        .environmentObject(UIStateViewModel())
    }
}
