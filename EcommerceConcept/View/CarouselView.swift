//
//  CarouselView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct CarouselView: View {
    @State private var selection = 0
    
    let productData: [HomeStore]
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(productData, id: \.id) { product in
                    HotSalesBlockView(hotSales: product,
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
                                             title: "Iphone 12",
                                             subtitle: "Súper. Mega. Rápido.",
                                             picture: "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both",
                                             isBuy: true)],
                     width: 414,
                     height: 896)
    }
}
