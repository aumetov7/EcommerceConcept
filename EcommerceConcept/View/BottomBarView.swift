//
//  BottomBarView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct BottomBarView: View {
    @Binding var showCart: Bool
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("DarkPurple"))
                .frame(width: width, height: height * 0.1)
            
            HStack(alignment: .center, spacing: 50) {
                HStack(alignment: .center) {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundColor(.white)
                    
                    Text("Explorer")
                        .font(.custom("MarkPro-Bold", size: 20))
                        .foregroundColor(.white)
                }
                
                Button {
                    showCart.toggle()
                } label: {
                    Image("bagIcon")
                        .resizedToFill(width: 15, height: 15)
                        .foregroundColor(.white)
                }

                Button {
                    // heart action
                } label: {
                    Image("heartIcon")
                        .resizedToFill(width: 15, height: 15)
                        .foregroundColor(.white)
                }
                
                Button {
                    // person action
                } label: {
                    Image("personIcon")
                        .resizedToFill(width: 15, height: 15)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(showCart: .constant(false), width: 414, height: 896)
    }
}
