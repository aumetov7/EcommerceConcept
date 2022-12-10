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
    
//    @ObservedObject var productDetailsVM: ProductDetailsViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Text("My Cart")
                        .font(.custom("MarkPro-Bold", size: 35))
                        .frame(height: geometry.size.height * 0.15, alignment: .bottom)
                        .padding(.horizontal)
                        .padding(.horizontal)
                    
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
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(.white)
                                                    .frame(width: geometry.size.width * 0.21, height: geometry.size.width * 0.21)
                                                
                                                Image(uiImage: item.image)
                                                    .resizedToFill(width: geometry.size.width * 0.19, height: geometry.size.width * 0.19)
                                                    .clipped()
                                            }
                                            
                                            VStack(alignment: .leading) {
                                                Text(item.title)
                                                    .foregroundColor(.white)
                                                    .font(.custom("MarkPro-Medium", size: 20))
                                                    .lineLimit(2)
                                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.14, alignment: .topLeading)
                                                
                                                Text("$\(item.price)")
                                                    .foregroundColor(Color("Orange"))
                                                    .font(.custom("MarkPro-Medium", size: 20))
                                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.05, alignment: .bottomLeading)
                                            }
                                            
                                            VStack {
                                                PickerButton(itemCount: item.count,
                                                             width: geometry.size.width,
                                                             height: geometry.size.height) { _ in
                                                    cartVM.decrease(itemId: item.id)
                                                } plusAction: { _ in
                                                    cartVM.addToCart(itemId: item.id)
                                                }

                                            }
                                            
                                            VStack {
                                                Button {
                                                    cartVM.removeFromCart(itemId: item.id)
                                                } label: {
                                                    Image("trashIcon")
                                                        .resizedToFill(width: 20, height: 20)
                                                        .foregroundColor(Color("LightGray"))
                                                }

                                            }
                                        }
                                    }
                                    .padding(.top, 8)
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.48, alignment: .top)   
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
                                    .foregroundColor(.white)
                                    .font(.custom("MarkPro", size: 15))
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading, spacing: 15) {
//                                        Text("$6,000 us")
                                        Text("$\(cartVM.carts.totalPrice)")
                                        
                                        Text(cartVM.carts.delivery)
                                    }
                                    .foregroundColor(.white)
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
                            
                            Button {
                                // add to cart action
                            } label: {
                                Text("Checkout")
                                    .font(.custom("MarkPro-Bold", size: 20))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(16)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Orange"))
                                }
                            }
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
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.custom("MarkPro-Medium", size: 20))
                                .padding(8)
                                .foregroundColor(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("DarkPurple"))
                                        .frame(width: 40, height: 40)
                                }
                        }
                        .padding(.leading)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(alignment: .center, spacing: 2) {
                            Text("Add address")
                                .font(.custom("MarkPro-Medium", size: 15))
                            
                            Button {
                                // location action
                            } label: {
                                Image("locationIcon")
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color("Orange"))
                                            .frame(width: 40, height: 40)
                                    }
                            }
                        }
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
            .environmentObject(CartViewModel())
    }
}
