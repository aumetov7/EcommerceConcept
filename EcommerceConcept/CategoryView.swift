//
//  CategoryView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryVM: CategoryViewModel
    
    let height: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 5) { index in
                    Button {
                        categoryVM.selectItem(index: index)
                    } label: {
                        VStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(categoryVM.category.states[index] ? Color("Orange") : Color.white)
                                
                                Image(categoryVM.category.icons[index])
                                    .resizedToFill(width: 0, height: 35)
                                    .foregroundColor(categoryVM.category.states[index] ? Color.white : Color("CategoryColor"))
                            }
                            
                            Text(categoryVM.category.names[index])
                                .foregroundColor(categoryVM.category.states[index] ? Color("Orange") : Color.black)
                                .font(.custom("MarkPro-Medium", size: 12))
                                .lineLimit(1)
                                .fixedSize()
                        }
                    }
                }
            }
        }
        .frame(height: height)
        .background(Color.gray)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(categoryVM: CategoryViewModel(), height: 100)
    }
}
