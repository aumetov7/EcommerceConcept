//
//  MainScreenView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var categoryVM = CategoryViewModel()
//    @StateObject private var productVM = ProductViewModel()
    @ObservedObject var productVM: ProductViewModel
    
    @State private var searchText = ""
    
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
                        categoryTitle(title: "Select Category", buttonLabel: "view all")
                        .padding(.horizontal)
                        
                        CategoryView(categoryVM: categoryVM,
                                     width: geometry.size.width * 0.17,
                                     height: geometry.size.height * 0.12)
                        
                        SearchBarView(searchText: $searchText)
                            .padding()
                        
                        categoryTitle(title: "Hot Sales", buttonLabel: "see more")
                        .padding(.horizontal)
                        
                        CarouselView(productData: productVM.product.homeStore,
                                     pictureData: productVM.picture.picture,
                                     width: geometry.size.width,
                                     height: geometry.size.height)
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Button {
                                // Location action
                            } label: {
                                HStack(spacing: 10) {
                                    Image("locationIcon")
                                        .resizedToFill(width: geometry.size.width * 0.02,
                                                       height: geometry.size.height * 0.02)
                                    
                                    Text("Zihuatanejo, Gro")
                                        .font(.custom("MarkPro-Medium", size: 15))
                                        .foregroundColor(.black)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.custom("MarkPro", size: 12))
                                        .foregroundColor(.black.opacity(0.2))
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                // Filter action
                            } label: {
                                Image("filterIcon")
                                    .resizedToFill(width: geometry.size.width * 0.02,
                                                   height: geometry.size.height * 0.02)
                            }
                        }
                    }
                .navigationBarTitleDisplayMode(.inline)
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
            .background(Color("BackgroundColor"))
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(productVM: ProductViewModel())
        
        MainScreenView(productVM: ProductViewModel())
            .previewDevice("iPhone SE (3rd generation)")
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
