//
//  ProductDetailsView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import SwiftUI

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var uiState: UIStateViewModel
    
    @StateObject private var productDetailsVM = ProductDetailsViewModel()
    
    @State private var title = ""
    @State private var price = 0
    @State private var selectedButton = 0
    @State private var colorSelected = 0
    @State private var memorySelected = 0
    
    let buttonNames = ["Shop", "Details", "Featured"]
    let icons = ["coreIcon", "cameraIcon", "ramIcon", "memoryIcon"]
    let text = ["Exynos 990", "108 + 12 mp", "8 GB", "256 GB"]
    let colorButton = ["Brown", "DarkPurple"]
    let memoryButton = ["128 GB", "256 GB"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    SnapCarousel(product: productDetailsVM,
                                 title: $title,
                                 price: $price,
                                 width: geometry.size.width,
                                 height: geometry.size.height)
                    .frame(height: geometry.size.height * 0.42)
                    .padding()
                    
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.white)
                            .ignoresSafeArea()
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Text(title)
                                    .font(.custom("MarkPro-Medium", size: 24))
                                
                                Spacer()
                                
                                Button {
                                    // favourites action
                                } label: {
                                    Image(systemName: "heart")
                                        .font(.custom("MarkPro-Medium", size: 18))
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color("DarkPurple"))
                                        }
                                }
                            }
                            .padding(.bottom)
                            
                            HStack {
                                ForEach(0 ..< 5, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                }
                                .font(.callout)
                                .foregroundColor(.yellow)
                            }
                            .padding(.bottom)
                            
                            HStack(alignment: .top) {
                                ForEach(0 ..< 3, id: \.self) { index in
                                    Button {
                                        selectedButton = index
                                    } label: {
                                        Text(buttonNames[index])
                                            .font(.custom("MarkPro-Bold", size: 20))
                                            .foregroundColor(selectedButton == index ? .black : .gray)
                                            .overlay(alignment: .bottom) {
                                                if selectedButton == index {
                                                    Rectangle()
                                                        .frame(width: buttonNames[index].count > 5 ? geometry.size.width * 0.25 : geometry.size.width * 0.2,
                                                               height: 3)
                                                        .offset(y: 5)
                                                        .foregroundColor(Color("Orange"))
                                                }
                                            }
                                        
                                        if index == 0 || index == 1 {
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            HStack(alignment: .center) {
                                ForEach(0 ..< 4, id: \.self) { index in
                                    VStack(alignment: .center) {
                                        Image(icons[index])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 22)
                                            .padding(.bottom, 2)
                                        Text(text[index])
                                            .font(.custom("MarkPro", size: 11))
                                    }
                                    .foregroundColor(.gray)
                                    
                                    if index != 3 {
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.bottom)
                            
                            Text("Select color and capacity")
                                .font(.custom("MarkPro-Medium", size: 16))
                            
                            HStack(alignment: .center, spacing: 25) {
                                ForEach(0 ..< 2, id: \.self) { index in
                                    Button {
                                        colorSelected = index
                                    } label: {
                                        ZStack(alignment: .center) {
                                            Circle()
                                                .foregroundColor(Color(colorButton[index]))
                                                .frame(width: 40)
                                            
                                            if colorSelected == index {
                                                Image(systemName: "checkmark")
                                                    .font(.custom("MarkPro-Bold", size: 20))
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                ForEach(0 ..< 2, id: \.self) { index in
                                    HStack(alignment: .center, spacing: 25) {
                                        Button {
                                            memorySelected = index
                                        } label: {
                                            Text(memoryButton[index])
                                                .font(.custom("MarkPro-Bold", size: 13))
                                                .foregroundColor(memorySelected == index ? .white : .gray)
                                                .padding(8)
                                                .background {
                                                    if memorySelected == index {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .foregroundColor(Color("Orange"))
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
                            
                            Button {
                                // add to cart action
                            } label: {
                                HStack(alignment: .center) {
                                    Text("Add to Cart")
                                    
                                    Spacer()
                                    
                                    Text("$\(price)")
                                }
                                .font(.custom("MarkPro-Bold", size: 20))
                                .padding(16)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Orange"))
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.top, 25)
                    }
                }
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
                    
                    ToolbarItem(placement: .principal) {
                        Text("Product Details")
                            .font(.custom("MarkPro-Medium", size: 18))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
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
                        .padding(.trailing)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color("BackgroundColor"))
        }
        .navigationBarBackButtonHidden()
    }
    
    func toString(price: Int) -> String {
        return "$" + String(price)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
            .environmentObject(UIStateViewModel())
    }
}
