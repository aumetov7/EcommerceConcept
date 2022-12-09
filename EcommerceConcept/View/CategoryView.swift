//
//  CategoryView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryVM: CategoryViewModel
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(0 ..< 5) { index in
                    Button {
                        categoryVM.buttonSelected = index
                    } label: {
                        VStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(categoryVM.buttonSelected == index ? Color("Orange") : Color.white)
                                
                                Image(categoryVM.category.icons[index])
                                    .resizedToFill(width: 0, height: 30)
                                    .foregroundColor(categoryVM.buttonSelected == index ? Color.white : Color("CategoryColor"))
                            }
                            .frame(width: width)
                            
                            Text(categoryVM.category.names[index])
                                .foregroundColor(categoryVM.buttonSelected == index ? Color("Orange") : Color.black)
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
        CategoryView(categoryVM: CategoryViewModel(), width: 71, height: 100)
    }
}
