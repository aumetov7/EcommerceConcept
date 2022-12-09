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
    let image: UIImage
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Button {
            showProductDetails.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading) {
                        Image(uiImage: image)
                            .resizedToFill(width: width * 0.4, height: height * 0.3)
                            .clipped()
                        
                        HStack(alignment: .center) {
                            Text("$\(bestSeller.discountPrice)")
                                .font(.custom("MarkPro-Bold", size: 16))
                                .foregroundColor(.black)
                            
                            Text("$\(bestSeller.priceWithoutDiscount)")
                                .font(.custom("MarkPro-Medium", size: 10))
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                        
                        Text(bestSeller.title)
                            .font(.custom("MarkPro", size: 10))
                            .foregroundColor(.black)
                    }
                    .padding(.bottom)
                    
                    Button {
                        // add to favourites action
                    } label: {
                        Image(systemName: "heart")
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
                            image: UIImage(),
                            width: 414,
                            height: 896)
    }
}
