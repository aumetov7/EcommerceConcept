//
//  CartProductView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 12/12/22.
//

import SwiftUI

struct CartProductView: View {
    @EnvironmentObject var cartVM: CartViewModel
    
    let phone: Phone
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        HStack(spacing: 16) {
            productPicture(width: width,
                           url: phone.image)
            
            VStack(alignment: .leading) {
                productTitle(title: phone.title,
                             width: width)
                
                productPrice(price: phone.price,
                             width: width)
            }
            
            PickerButton(itemCount: phone.count,
                         width: width,
                         height: height) { _ in
                cartVM.decrease(itemId: phone.id)
            } plusAction: { _ in
                cartVM.addToCart(itemId: phone.id)
            }
            
            trashButton(id: phone.id)
        }
    }
}

struct CartProductView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductView(phone: Phone(id: 1,
                                     title: "Samsung Note 20 Ultra",
                                     image: "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
                                     price: 1500,
                                     count: 1),
                        width: 414,
                        height: 896)
    }
}

extension CartProductView {
    @ViewBuilder
    func productPicture(width: CGFloat, url: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .frame(width: width * 0.21,
                       height: width * 0.21)
            
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizedToFill(width: width * 0.19,
                                   height: width * 0.19)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
        }
    }
    
    @ViewBuilder
    func productTitle(title: String, width: CGFloat) -> some View {
        Text(title)
            .foregroundColor(Color.white)
            .font(.custom("MarkPro-Medium", size: 20))
            .lineLimit(2)
            .frame(width: width * 0.45,
                   height: width * 0.14,
                   alignment: .topLeading)
    }
    
    @ViewBuilder
    func productPrice(price: Int, width: CGFloat) -> some View {
        Text("$\(price)")
            .foregroundColor(Color("Orange"))
            .font(.custom("MarkPro-Medium", size: 20))
            .frame(width: width * 0.45,
                   height: width * 0.05,
                   alignment: .bottomLeading)
    }
    
    @ViewBuilder
    func trashButton(id: Int) -> some View {
        Button {
            cartVM.removeFromCart(itemId: id)
        } label: {
            Image("trashIcon")
                .resizedToFill(width: 20,
                               height: 20)
                .foregroundColor(Color("LightGray"))
        }
    }
}
