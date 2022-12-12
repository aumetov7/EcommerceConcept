//
//  PickerButtonLabel.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 12/12/22.
//

import SwiftUI

struct PickerButtonLabel: View {
    let label: String
    let radius: CGFloat
    let corners: UIRectCorner
    let width: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(radius,
                              corners: corners)
                .frame(width: 25,
                       height: width * 0.07)
            
            Text(label)
                .foregroundColor(Color.white)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

struct PickerButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        PickerButtonLabel(label: "-",
                          radius: 26,
                          corners: [.topLeft, .topRight],
                          width: 414)
    }
}
