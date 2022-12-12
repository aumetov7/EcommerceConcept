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
                        .frame(height: geometry.size.height * 0.15,
                               alignment: .bottom)
                        .padding(.horizontal)
                        .padding(.leading)
                    
                    CartBlockView(phone: cartVM.carts.phone,
                                  width: geometry.size.width,
                                  height: geometry.size.height)
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
            .environmentObject(CartViewModel(productDetails: ProductDetails(basket: [Basket(id: 1,
                                                                                            images: "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
                                                                                            price: 1500,
                                                                                            title: "Samsung Note 20 Ultra")],
                                                                            delivery: "Free",
                                                                            id: "1",
                                                                            total: 1500)))
    }
}

// MARK: - Properties

extension MyCartView {
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
