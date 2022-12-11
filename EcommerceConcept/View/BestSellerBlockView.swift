//
//  BestSellerBlockView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct BestSellerBlockView: View {
    @Binding var showProductDetails: Bool
    
    let bestSeller: BestSeller
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
            
            ZStack(alignment: .topTrailing) {
                Button(action: {
                    showProductDetails.toggle()
                }, label: {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: bestSeller.picture)) { image in
                            image
                                .resizedToFill(width: width * 0.4, height: height * 0.3)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: width * 0.4, height: height * 0.3)
                        
                        priceText
                        
                        Text(bestSeller.title)
                            .font(.custom("MarkPro", size: 10))
                            .foregroundColor(.black)
                    }
                })
                .padding(.bottom)
                
                isFavouritesButton
            }
        }
    }
}

struct BestSellerBlockView_Previews: PreviewProvider {
    static var previews: some View {
        BestSellerBlockView(showProductDetails: .constant(false),
                            bestSeller: BestSeller(id: 1,
                                                   isFavorites: true,
                                                   title: "Samsung Galaxy s20 Ultra",
                                                   priceWithoutDiscount: 1500,
                                                   discountPrice: 1407,
                                                   picture: "https://shop.gadgetufa.ru/images/upload/52534-smartfon-samsung-galaxy-s20-ultra-12-128-chernyj_1024.jpg"),
                            width: 414,
                            height: 896)
    }
}

extension BestSellerBlockView {
    var priceText: some View {
        HStack(alignment: .center) {
            Text("$\(bestSeller.discountPrice)")
                .font(.custom("MarkPro-Bold", size: 16))
                .foregroundColor(.black)
            
            Text("$\(bestSeller.priceWithoutDiscount)")
                .font(.custom("MarkPro-Medium", size: 10))
                .strikethrough()
                .foregroundColor(.gray)
        }
    }
    
    var isFavouritesButton: some View {
        Button {
            // add to favourites action
        } label: {
            Image(systemName: bestSeller.isFavorites ? "heart.fill" : "heart")
                .font(.caption)
                .foregroundColor(Color("Orange"))
                .padding(8)
                .background {
                    Circle()
                        .foregroundColor(Color.white)
                }
                .padding(.top)
        }
    }
}
