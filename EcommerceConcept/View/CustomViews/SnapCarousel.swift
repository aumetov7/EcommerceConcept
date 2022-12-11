//
//  SnapCarousel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct SnapCarousel: View {
    let basket: [Basket]
    
    @Binding var itemId: Int
    @Binding var title: String
    @Binding var price: Int
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Canvas {
            Carousel(numberOfItems: CGFloat(basket.count),
                     spacing: width * 0.08,
                     widthOfHiddenCards: width * 0.1) {
                ForEach(basket, id: \.self.id) { item in
                    SnapCarouselItem(itemId: $itemId,
                                     title: $title,
                                     price: $price,
                                     basket: item,
                                     width: width,
                                     height: height)
                }
            }
        }
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarousel(basket: [Basket(id: 1,
                                     images: "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
                                     price: 1500,
                                     title: "Galaxy Note 20 Ultra"),
                              Basket(id: 2, images: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-silver-select?wid=470&hei=556&fmt=jpeg&qlt=95&.v=1631652954000",
                                     price: 1800,
                                     title: "iPhone 13")],
                     itemId: .constant(1),
                     title: .constant(""),
                     price: .constant(0),
                     width: 414,
                     height: 896)
        .environmentObject(UIStateViewModel())
    }
}
