//
//  MainScreenView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var productDetailsVM = ProductDetailsViewModel(productDetailsService: ProductDetailsService(network: Network()))
    
    @ObservedObject var productVM: ProductViewModel
    
    @State private var searchText = ""
    @State private var showMenu = false
    @State private var showProductDetails = false
    @State private var showCart = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        NavigationLink(destination: ProductDetailsView(productDetailsVM: productDetailsVM),
                                       isActive: $showProductDetails) {
                            EmptyView()
                        }
                        
                        NavigationLink(destination: MyCartView(),
                                       isActive: $showCart) {
                            EmptyView()
                        }
                        
                        header
                        .padding(.bottom, 8)
                        
                        categoryTitle(title: "Select Category",
                                      buttonLabel: "view all")
                        
                        CategoryView(width: geometry.size.width * 0.17,
                                     height: geometry.size.height * 0.12)
                        
                        SearchBarView(searchText: $searchText)
                            .padding()
                        
                        categoryTitle(title: "Hot Sales",
                                      buttonLabel: "see more")
                        
                        CarouselView(productData: productVM.products.homeStore,
                                     width: geometry.size.width,
                                     height: geometry.size.height)
                        
                        categoryTitle(title: "Best Seller",
                                      buttonLabel: "see more")
                        
                        BestSellerView(showProductDetails: $showProductDetails,
                                       productData: productVM.products.bestSeller,
                                       width: geometry.size.width,
                                       height: geometry.size.height)
                        .padding(.bottom)
                    }
                    .padding(.bottom)
                    .halfSheet(showSheet: $showMenu) {
                        FilterView(showMenu: $showMenu,
                                   width: geometry.size.width,
                                   height: geometry.size.height)
                    } onEnd: { }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            BottomBarView(showCart: $showCart,
                                          width: geometry.size.width,
                                          height: geometry.size.height)
                                .frame(maxHeight: .infinity,
                                       alignment: .bottom)
                        }
                    }
                }
                .gesture(DragGesture()
                    .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                    }))
                .gesture(TapGesture()
                    .onEnded({ _ in
                        UIApplication.shared.dismissKeyboard()
                    }))
            }
            .navigationBarTitleDisplayMode(.inline)
            .clipped()
            .background(Color("BackgroundColor"))
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .environmentObject(UIStateViewModel())
        .environmentObject(CartViewModel(productDetails: productDetailsVM.products))
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(productVM: ProductViewModel(productService: ProductService(network: Network())))
            .environmentObject(CartViewModel(productDetails: ProductDetails(basket: [],
                                                                            delivery: "",
                                                                            id: "",
                                                                            total: 0)))
    }
}

extension MainScreenView {
    @ViewBuilder
    func categoryTitle(title: String, buttonLabel: String) -> some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.custom("MarkPro-Bold", size: 25))
            
            Spacer()
            
            Button {
                // View all action
            } label: {
                Text(buttonLabel)
                    .font(.custom("MarkPro", size: 15))
                    .foregroundColor(Color("Orange"))
            }
        }
        .padding(.horizontal)
    }
    
    var locationButton: some View {
        Button {
            // Location action
        } label: {
            HStack(spacing: 10) {
                Image("locationIcon")
                    .resizedToFill(width: 15,
                                   height: 15)
                    .foregroundColor(Color("Orange"))
                
                Text("Zihuatanejo, Gro")
                    .font(.custom("MarkPro-Medium", size: 15))
                    .foregroundColor(Color.black)
                
                Image(systemName: "chevron.down")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.2))
            }
        }
    }
    
    var filterButton: some View {
        Button {
            showMenu.toggle()
        } label: {
            Image("filterIcon")
                .resizedToFill(width: 15,
                               height: 15)
                .padding()
                .background {
                    Rectangle()
                        .foregroundColor(Color.clear)
                }
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
                .overlay(alignment: .leading) {
                    EmptyView()
                }
            
            locationButton
            
            Spacer()
                .overlay(alignment: .trailing) {
                    filterButton
                }
        }
    }
}
