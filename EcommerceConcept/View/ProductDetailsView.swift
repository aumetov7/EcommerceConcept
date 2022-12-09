//
//  ProductDetailsView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var uiState: UIStateViewModel
    
    @StateObject private var productDetailsVM = ProductDetailsViewModel()
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                            .overlay(alignment: .leading) {
                                Button {
                                    // back action
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
                            }
                        
                        Text("Product Details")
                            .font(.custom("MarkPro-Medium", size: 18))
                        
                        Spacer()
                            .overlay(alignment: .trailing) {
                                Button {
                                    // bag action
                                } label: {
                                    Image("bagIcon")
                                        .resizedToFill(width: 20, height: 20)
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color("Orange"))
                                                .frame(width: 40, height: 40)
                                        }
                                }
                            }
                    }
                    .padding(.horizontal)
                    .padding([.top, .bottom], 6)
                    .padding(.bottom)
                    
                    SnapCarousel(product: productDetailsVM,
                                 width: geometry.size.width,
                                 height: geometry.size.height)
                }
                .padding(.horizontal)
            }
            .background(Color("BackgroundColor"))
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(productDetailsVM.product.basket.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(productDetailsVM.product.basket.count) * distance(item)
        
        return sin(angle) * 250
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
            .environmentObject(UIStateViewModel())
    }
}
