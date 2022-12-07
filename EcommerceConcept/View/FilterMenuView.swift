//
//  FilterMenuView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct FilterMenuView: View {
    @Binding var isExpanded: Bool
    
    let title: String
    let item: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("MarkPro-Medium", size: 18))
            
            CustomDisclosureGroup(animation: .easeInOut(duration: 0.2), isExpanded: $isExpanded) {
                isExpanded.toggle()
            } prompt: {
                HStack {
                    Text(item)
                        .font(.custom("MarkPro", size: 18))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(isExpanded ? Angle(degrees: 180) : .zero)
                }
                .padding([.top, .bottom], 8)
                .padding(.horizontal)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                        .foregroundColor(.clear)
                })
                .padding(.bottom)
            } expandedView: {
                VStack(alignment: .leading) {
                    ForEach(0 ..< 3, id: \.self) { _ in
                        Text(item)
                            .padding(.bottom, 2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .font(.custom("MarkPro", size: 18))
            }
        }
    }
}

struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(isExpanded: .constant(false), title: "Brand", item: "Samsung")
    }
}
