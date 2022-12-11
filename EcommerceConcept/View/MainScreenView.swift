//
//  MainScreenView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    
    @ObservedObject var productVM: ProductViewModel
    @ObservedObject var productDetailsVM: ProductDetailsViewModel
    
    @State private var searchText = ""
    @State private var showMenu = false
    @State private var showProductDetails = false
    @State private var showCart = false
    
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
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        NavigationLink(destination: ProductDetailsView(productDetailsVM: productDetailsVM), isActive: $showProductDetails) {
                            EmptyView()
                        }
                        
                        NavigationLink(destination: MyCartView(), isActive: $showCart) {
                            EmptyView()
                        }
                        
                        HStack {
                            Spacer()
                                .overlay(alignment: .leading) {
                                    EmptyView()
                                }
                            
                            Button {
                                // Location action
                            } label: {
                                HStack(spacing: 10) {
                                    Image("locationIcon")
                                        .resizedToFill(width: geometry.size.width * 0.02,
                                                       height: geometry.size.height * 0.02)
                                        .foregroundColor(Color("Orange"))
                                    
                                    Text("Zihuatanejo, Gro")
                                        .font(.custom("MarkPro-Medium", size: 15))
                                        .foregroundColor(.black)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.custom("MarkPro", size: 12))
                                        .foregroundColor(.black.opacity(0.2))
                                }
                            }
                            
                            Spacer()
                                .overlay(alignment: .trailing) {
                                    Button {
                                        showMenu.toggle()
                                        print("Tapped")
                                    } label: {
                                        Image("filterIcon")
                                            .resizedToFill(width: 15,
                                                           height: 15)
                                            .padding([.top, .leading, .bottom], 8)
                                            .background {
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                            }
                                    }
                                }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        
                        categoryTitle(title: "Select Category", buttonLabel: "view all")
                            .padding(.horizontal)
                        
                        CategoryView(categoryVM: categoryVM,
                                     width: geometry.size.width * 0.17,
                                     height: geometry.size.height * 0.12)
                        
                        SearchBarView(searchText: $searchText)
                            .padding()
                        
                        categoryTitle(title: "Hot Sales", buttonLabel: "see more")
                            .padding(.horizontal)
                        
                        CarouselView(productData: productVM.products.homeStore,
                                     width: geometry.size.width,
                                     height: geometry.size.height)
                        
                        categoryTitle(title: "Best Seller", buttonLabel: "see more")
                            .padding(.horizontal)
                        
                        BestSellerView(showProductDetails: $showProductDetails,
                                       productData: productVM.products.bestSeller,
                                       width: geometry.size.width,
                                       height: geometry.size.height)
                        .padding(.bottom)
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .halfSheet(showSheet: $showMenu) {
                        FilterView(showMenu: $showMenu,
                                   width: geometry.size.width,
                                   height: geometry.size.height)
                    } onEnd: {
                        print("Dismiss")
                        print("\(showMenu)")
                    }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            BottomBarView(showCart: $showCart, width: geometry.size.width, height: geometry.size.height)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }
                    .padding(.bottom)
                }
                .gesture(DragGesture()
                    .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                    }))
                .gesture(TapGesture()
                    .onEnded({ _ in
                        UIApplication.shared.dismissKeyboard()
                    }))
                .clipped()
                .environmentObject(CartViewModel())
            }
            .background(Color("BackgroundColor"))
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .environmentObject(UIStateViewModel())
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(productVM: ProductViewModel(productService: ProductService(network: Network())),
                       productDetailsVM: ProductDetailsViewModel(productDetailsService: ProductDetailsService(network: Network())))
            .environmentObject(CartViewModel())
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func halfSheet<SheetView: View> (showSheet: Binding<Bool>,
                                     @ViewBuilder sheetView: @escaping () -> SheetView,
                                     onEnd: @escaping () -> ()) -> some View {
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), onEnd: onEnd, showSheet: showSheet)
            )
    }
}
