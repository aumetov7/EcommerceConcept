//
//  BestSellerView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct BestSellerView: View {
    @Binding var showProductDetails: Bool
    
    let productData: [BestSeller]
    let width: CGFloat
    let height: CGFloat
    
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 10),
                               GridItem(.flexible(), spacing: 10)]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(productData, id: \.id) { product in
                BestSellerBlockView(showProductDetails: $showProductDetails,
                                    bestSeller: product,
                                    width: width,
                                    height: height)
            }
        }
        .padding(.horizontal)
    }
}

struct BestSellerView_Previews: PreviewProvider {
    static var previews: some View {
        BestSellerView(showProductDetails: .constant(false),
                       productData: [BestSeller(id: 1,
                                                isFavorites: true,
                                                title: "Samsung Galaxy s20 Ultra",
                                                priceWithoutDiscount: 1500,
                                                discountPrice: 1407,
                                                picture: "https://shop.gadgetufa.ru/images/upload/52534-smartfon-samsung-galaxy-s20-ultra-12-128-chernyj_1024.jpg")],
                       width: 414,
                       height: 896)
    }
}
