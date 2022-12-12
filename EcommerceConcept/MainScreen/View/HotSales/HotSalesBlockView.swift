//
//  HotSalesBlockView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct HotSalesBlockView: View {
    let hotSales: HomeStore
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
            
            HStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        if hotSales.isNew != nil {
                            newMark
                        }
                        
                        Text(hotSales.title)
                            .font(.custom("MarkPro-Bold", size: 22))
                            .foregroundColor(Color.white)
                            .lineLimit(2)
                        
                        Text(hotSales.subtitle)
                            .font(.custom("MarkPro", size: 11))
                            .foregroundColor(Color.white)
                    }
                    .frame(height: height * 0.16,
                           alignment: .top)
                    
                    buyNowButton
                }
                .frame(width: width * 0.3,
                       height: height * 0.25)
                .padding()
                
                Spacer()
                
                AsyncImage(url: URL(string: hotSales.picture)) { image in
                    image
                        .resizedToFill(width: width * 0.45,
                                       height: height * 0.25)
                        .cornerRadius(10, corners: [.bottomRight, .topRight])
                        .contentShape(Rectangle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: width * 0.45,
                       height: height * 0.25)
            }
            .frame(height: height * 0.25)
        }
        .frame(height: height * 0.25)
    }
}

struct HotSalesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        HotSalesBlockView(hotSales: HomeStore(id: 1,
                                              isNew: true,
                                              title: "Iphone 12",
                                              subtitle: "Súper. Mega. Rápido.",
                                              picture: "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both",
                                              isBuy: true),
                          width: 414,
                          height: 896)
    }
}

// MARK: - Properties

extension HotSalesBlockView {
    var newMark: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("Orange"))
                .frame(width: 30)
            
            Text("New")
                .font(.custom("MarkPro", size: 10))
                .foregroundColor(Color.white)
        }
    }
    
    var buyNowButton: some View {
        Button {
            // buy action
        } label: {
            Text("Buy now!")
                .font(.custom("MarkPro-Bold", size: 11))
                .foregroundColor(Color.black)
                .padding(5)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.white)
                }
        }
    }
}
