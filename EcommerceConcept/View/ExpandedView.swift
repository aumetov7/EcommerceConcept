//
//  ExpandedView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

struct ExpandedView: View {
    @Binding var isExpanded: Bool
    
    let buttonAction: (String) -> ()
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(items, id: \.self) { element in
                Button {
                    buttonAction(element)
                    isExpanded.toggle()
                } label: {
                    Text(element)
                        .font(.custom("MarkPro", size: 18))
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .font(.custom("MarkPro", size: 18))
    }
}

struct ExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedView(isExpanded: .constant(false), buttonAction: { _ in }, items: [""])
    }
}
