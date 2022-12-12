//
//  CartBlockView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 12/12/22.
//

import SwiftUI

struct CartBlockView: View {
    @EnvironmentObject var cartVM: CartViewModel
    
    let phone: [Phone]
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .foregroundColor(Color("DarkPurple"))
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 25) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 40) {
                        ForEach(phone, id: \.id) { item in
                            CartProductView(phone: item,
                                            width: width,
                                            height: height)
                        }
                        .padding(.top, 8)
                    }
                    .frame(width: width,
                           height: height * 0.48,
                           alignment: .top)
                }
                
                Divider()
                    .overlay {
                        Color.white
                    }
                
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Total")
                            
                            Text("Delivery")
                        }
                        .foregroundColor(Color.white)
                        .font(.custom("MarkPro", size: 15))
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("$\(cartVM.carts.totalPrice)")
                            
                            Text(cartVM.carts.delivery)
                        }
                        .foregroundColor(Color.white)
                        .font(.custom("MarkPro-Bold", size: 15))
                    }
                }
                .frame(height: height * 0.05)
                .padding(.horizontal)
                .padding(.horizontal)
                
                Divider()
                    .overlay {
                        Color.gray
                    }
                
                checkoutButton
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .padding(.horizontal)
            }
            .padding(.top, 50)
        }
    }
}

struct CartBlock_Previews: PreviewProvider {
    static var previews: some View {
        CartBlockView(phone: [Phone(id: 1,
                                title: "Samsung Note 20 Ultra",
                                image: "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
                                price: 1500,
                                count: 1)],
                  width: 414,
                  height: 896)
        .environmentObject(CartViewModel(productDetails: ProductDetails(basket: [],
                                                                        delivery: "",
                                                                        id: "",
                                                                        total: 0)))
    }
}

extension CartBlockView {
    var checkoutButton: some View {
        Button {
            // add to cart action
        } label: {
            Text("Checkout")
                .font(.custom("MarkPro-Bold", size: 20))
                .frame(maxWidth: .infinity, alignment: .center)
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
