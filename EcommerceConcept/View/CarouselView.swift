//
//  CarouselView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct CarouselView: View {
    @State private var selection = 0
    
    var productData: [HomeStore]
    var pictureData: [Int: UIImage]
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(productData, id: \.id) { product in
                    HotSalesBlockView(hotSales: product,
                                      picture: pictureData[product.id] ?? UIImage(),
                                      width: width,
                                      height: height)
                        .tag(product.id)
                        .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(height: height * 0.25)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(productData: [HomeStore(id: 1,
                                             isNew: true,
                                             title: "",
                                             subtitle: "",
                                             picture: "",
                                             isBuy: true)], pictureData: [1: UIImage()], width: 414, height: 896)
    }
}
