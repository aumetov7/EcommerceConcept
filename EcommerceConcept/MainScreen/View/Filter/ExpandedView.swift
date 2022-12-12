//
//  ExpandedView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

struct ExpandedView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedElement: Int
    
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< items.count, id: \.self) { index in
                Button {
                    selectedElement = index
                    isExpanded.toggle()
                } label: {
                    Text(items[index])
                        .font(.custom("MarkPro", size: 18))
                        .foregroundColor(Color.black)
                        .padding(.bottom, 2)
                }
            }
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding(.horizontal)
        .font(.custom("MarkPro", size: 18))
    }
}

struct ExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedView(isExpanded: .constant(false),
                     selectedElement: .constant(0),
                     items: [""])
    }
}
