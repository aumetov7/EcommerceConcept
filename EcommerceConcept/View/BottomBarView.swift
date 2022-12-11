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
                titleText
                
                bagButton
                favouritesButton
                profileButton
            }
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(showCart: .constant(false), width: 414, height: 896)
    }
}

extension BottomBarView {
    var titleText: some View {
        HStack(alignment: .center) {
            Image(systemName: "circle.fill")
                .font(.caption2)
                .foregroundColor(Color.white)
            
            Text("Explorer")
                .font(.custom("MarkPro-Bold", size: 20))
                .foregroundColor(Color.white)
        }
    }
    
    var bagButton: some View {
        Button {
            showCart.toggle()
        } label: {
            Image("bagIcon")
                .resizedToFill(width: 15, height: 15)
                .foregroundColor(Color.white)
        }
    }
    
    var favouritesButton: some View {
        Button {
            // heart action
        } label: {
            Image("heartIcon")
                .resizedToFill(width: 15, height: 15)
                .foregroundColor(Color.white)
        }
    }
    
    var profileButton: some View {
        Button {
            // person action
        } label: {
            Image("personIcon")
                .resizedToFill(width: 15, height: 15)
                .foregroundColor(Color.white)
        }
    }
}
