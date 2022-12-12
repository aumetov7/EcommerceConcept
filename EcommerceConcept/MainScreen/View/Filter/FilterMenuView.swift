//
//  FilterMenuView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct FilterMenuView<Content: View>: View {
    @Binding var isExpanded: Bool
    
    let content: Content
    let title: String
    let item: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("MarkPro-Medium", size: 18))
            
            CustomDisclosureGroup(animation: .easeInOut(duration: 0.2),
                                  isExpanded: $isExpanded) {
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
                })
                .padding(.bottom)
            } expandedView: {
                content
            }
        }
    }
}

struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(isExpanded: .constant(false),
                       content: EmptyView(),
                       title: "Brand",
                       item: "Samsung")
    }
}
