//
//  ProductDetailsBlockView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 12/12/22.
//

import SwiftUI

struct ProductDetailsBlockView: View {
    @EnvironmentObject var cartVM: CartViewModel
    
    @State private var selectedButton = 0
    @State private var colorSelected = 0
    @State private var memorySelected = 0
    
    @Binding var itemId: Int
    @Binding var title: String
    @Binding var price: Int
    
    let details = Detail()
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .foregroundColor(Color.white)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(title)
                        .font(.custom("MarkPro-Medium", size: 24))
                    
                    Spacer()
                    
                    favouritesButton
                }
                .padding(.bottom)
                
                HStack {
                    ForEach(0 ..< 5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                    }
                    .font(.callout)
                    .foregroundColor(Color.yellow)
                }
                .padding(.bottom)
                
                categoryButtons(width: width)
                .padding(.horizontal)
                .padding(.bottom)
                
                detailsIcons
                .padding(.bottom)
                
                Text("Select color and capacity")
                    .font(.custom("MarkPro-Medium", size: 16))
                
                HStack(alignment: .center, spacing: 25) {
                    colorSelecter
                    
                    Spacer()
                    
                    memorySelecter
                }
                .padding(.bottom)
                
                addToCartButton
            }
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.top, 25)
        }
    }
}

struct ProductDetailsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsBlockView(itemId: .constant(1),
                                title: .constant(""),
                                price: .constant(0),
                                width: 414,
                                height: 896)
            .environmentObject(CartViewModel(productDetails: ProductDetails(basket: [],
                                                                            delivery: "",
                                                                            id: "",
                                                                            total: 0)))
    }
}

extension ProductDetailsBlockView {
    var favouritesButton: some View {
        Button {
            // favourites action
        } label: {
            Image(systemName: "heart")
                .font(.custom("MarkPro-Medium", size: 18))
                .padding(8)
                .foregroundColor(Color.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("DarkPurple"))
                }
        }
    }
    
    @ViewBuilder
    func categoryButtons(width: CGFloat) -> some View {
        HStack(alignment: .top) {
            ForEach(0 ..< 3, id: \.self) { index in
                Button {
                    selectedButton = index
                } label: {
                    Text(details.buttonNames[index])
                        .font(.custom("MarkPro-Bold", size: 20))
                        .foregroundColor(selectedButton == index ? Color.black : Color.gray)
                        .overlay(alignment: .bottom) {
                            if selectedButton == index {
                                Rectangle()
                                    .frame(width: details.buttonNames[index].count > 5 ? width * 0.25 : width * 0.2,
                                           height: 3)
                                    .offset(y: 5)
                                    .foregroundColor(Color("Orange"))
                            }
                        }
                    
                    if index != 2 {
                        Spacer()
                    }
                }
            }
        }
    }
    
    var detailsIcons: some View {
        HStack(alignment: .center) {
            ForEach(0 ..< 4, id: \.self) { index in
                detailIcon(index: index)
                
                if index != 3 {
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    func detailIcon(index: Int) -> some View {
        VStack(alignment: .center) {
            Image(details.icons[index])
                .resizable()
                .scaledToFit()
                .frame(width: 25,
                       height: 22)
                .padding(.bottom, 2)
            Text(details.text[index])
                .font(.custom("MarkPro", size: 11))
        }
        .foregroundColor(.gray)
    }
    
    var colorSelecter: some View {
        ForEach(0 ..< 2, id: \.self) { index in
            Button {
                colorSelected = index
            } label: {
                colorLabel(index: index)
            }
        }
    }
    
    @ViewBuilder
    func colorLabel(index: Int) -> some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(Color(details.colorButton[index]))
                .frame(width: 40)
            
            if colorSelected == index {
                Image(systemName: "checkmark")
                    .font(.custom("MarkPro-Bold", size: 20))
                    .foregroundColor(Color.white)
            }
        }
    }
    
    var memorySelecter: some View {
        ForEach(0 ..< 2, id: \.self) { index in
            HStack(alignment: .center, spacing: 25) {
                Button {
                    memorySelected = index
                } label: {
                    memoryLabel(index: index)
                }
            }
        }
    }
    
    @ViewBuilder
    func memoryLabel(index: Int) -> some View {
        Text(details.memoryButton[index])
            .font(.custom("MarkPro-Bold", size: 13))
            .foregroundColor(memorySelected == index ? Color.white : Color.gray)
            .padding(8)
            .background {
                if memorySelected == index {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("Orange"))
                }
            }
    }
    
    var addToCartButton: some View {
        Button {
            cartVM.addToCart(itemId: itemId)
        } label: {
            HStack(alignment: .center) {
                Text("Add to Cart")
                
                Spacer()
                
                Text("$\(price)")
            }
            .font(.custom("MarkPro-Bold", size: 20))
            .padding(16)
            .padding(.horizontal)
            .foregroundColor(Color.white)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("Orange"))
            }
        }
    }
}
