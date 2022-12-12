//
//  ProductDetailsView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import SwiftUI

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var cartVM: CartViewModel
    
    @ObservedObject var productDetailsVM: ProductDetailsViewModel
    
    @State private var showCart = false
    @State private var itemId = 1
    @State private var title = ""
    @State private var price = 0
    @State private var selectedButton = 0
    @State private var colorSelected = 0
    @State private var memorySelected = 0
    
    let details = Detail()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    NavigationLink(destination: MyCartView(),
                                   isActive: $showCart) {
                        EmptyView()
                    }
                    
                    SnapCarousel(basket: productDetailsVM.products.basket,
                                 itemId: $itemId,
                                 title: $title,
                                 price: $price,
                                 width: geometry.size.width,
                                 height: geometry.size.height)
                    .frame(height: geometry.size.height * 0.42)
                    .padding()
                    
                    ProductDetailsBlockView(itemId: $itemId,
                                            title: $title,
                                            price: $price,
                                            width: geometry.size.width,
                                            height: geometry.size.height)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton(presentationMode: presentationMode)
                        .padding(.leading)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Product Details")
                            .font(.custom("MarkPro-Medium", size: 18))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        bagButton
                        .padding(.trailing)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $productDetailsVM.hasError) {
                    if case .failed(let error) = productDetailsVM.state {
                        return Alert(title: Text("Error"),
                                     message: Text(error.localizedDescription))
                        
                    } else {
                        return Alert(title: Text("Error"),
                                     message: Text("Something went wrong"))
                    }
                }
            }
            .background(Color("BackgroundColor"))
        }
        .navigationBarBackButtonHidden()
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(productDetailsVM: ProductDetailsViewModel(productDetailsService: ProductDetailsService(network: Network())))
            .environmentObject(UIStateViewModel())
            .environmentObject(CartViewModel(productDetails: ProductDetails(basket: [],
                                                                            delivery: "",
                                                                            id: "",
                                                                            total: 0)))
    }
}

extension ProductDetailsView {
    var bagButton: some View {
        Button {
            showCart.toggle()
        } label: {
            ZStack(alignment: .center) {
                Image("bagIcon")
                    .resizedToFill(width: 25,
                                   height: 25)
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Orange"))
                            .frame(width: 40,
                                   height: 40)
                    }
                
                if !cartVM.carts.phone.isEmpty {
                    Text("\(cartVM.carts.totalCount)")
                        .font(.custom("MarkPro-Medium", size: 18))
                        .padding(.top, 4)
                        .foregroundColor(Color("DarkPurple"))
                }
            }
        }
    }
}
