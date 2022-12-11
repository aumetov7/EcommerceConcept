//
//  MyCartView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct MyCartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Text("My Cart")
                        .font(.custom("MarkPro-Bold", size: 35))
                        .frame(height: geometry.size.height * 0.15, alignment: .bottom)
                        .padding(.horizontal)
                        .padding(.leading)
                    
                    ZStack(alignment: .top) {
                        Rectangle()
                            .cornerRadius(30, corners: [.topLeft, .topRight])
                            .foregroundColor(Color("DarkPurple"))
                            .ignoresSafeArea()
                        
                        VStack(alignment: .leading, spacing: 25) {
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 40) {
                                    ForEach(cartVM.carts.phone, id: \.id) { item in
                                        HStack(spacing: 16) {
                                            productPicture(width: geometry.size.width,
                                                           url: item.image)
                                            
                                            VStack(alignment: .leading) {
                                                productTitle(title: item.title,
                                                             width: geometry.size.width)
                                                
                                                productPrice(price: item.price,
                                                             width: geometry.size.width)
                                            }
                                            
                                            PickerButton(itemCount: item.count,
                                                         width: geometry.size.width,
                                                         height: geometry.size.height) { _ in
                                                cartVM.decrease(itemId: item.id)
                                            } plusAction: { _ in
                                                cartVM.addToCart(itemId: item.id)
                                            }
                                            
                                            trashButton(id: item.id)
                                        }
                                    }
                                    .padding(.top, 8)
                                }
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height * 0.48,
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
                            .frame(height: geometry.size.height * 0.05)
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
                    .padding(.top)
                    .padding(.top)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton(presentationMode: presentationMode)
                            .padding(.leading)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addressButton
                            .padding(.trailing)
                    }
                }
            }
            .background(Color("BackgroundColor"))
        }
        .navigationBarBackButtonHidden()
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        MyCartView()
            .environmentObject(CartViewModel(productDetails: ProductDetails(basket: [], delivery: "", id: "", total: 0)))
    }
}

extension MyCartView {
    @ViewBuilder
    func productPicture(width: CGFloat, url: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .frame(width: width * 0.21, height: width * 0.21)
            
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizedToFill(width: width * 0.19, height: width * 0.19)
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
                .resizedToFill(width: 20, height: 20)
                .foregroundColor(Color("LightGray"))
        }
    }
    
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
    
    var addressButton: some View {
        HStack(alignment: .center, spacing: 2) {
            Text("Add address")
                .font(.custom("MarkPro-Medium", size: 15))
            
            Button {
                // location action
            } label: {
                Image("locationIcon")
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Orange"))
                            .frame(width: 40, height: 40)
                    }
            }
        }
    }
}
