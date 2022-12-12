//
//  CategoryView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedButton = 0
    
    let category = Category()
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(0 ..< category.names.count, id: \.self) { index in
                    Button {
                        selectedButton = index
                    } label: {
                        VStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(selectedButton == index ? Color("Orange") : Color.white)
                                
                                Image(category.icons[index])
                                    .resizedToFill(width: 0, height: 30)
                                    .foregroundColor(selectedButton == index ? Color.white : Color("CategoryColor"))
                            }
                            .frame(width: width)
                            
                            Text(category.names[index])
                                .foregroundColor(selectedButton == index ? Color("Orange") : Color.black)
                                .font(.custom("MarkPro-Medium", size: 12))
                                .lineLimit(1)
                                .fixedSize()
                        }
                    }
                    .frame(height: height)
                }
            }
            .padding(.horizontal)
            .padding(.horizontal)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(width: 71,
                     height: 100)
    }
}
