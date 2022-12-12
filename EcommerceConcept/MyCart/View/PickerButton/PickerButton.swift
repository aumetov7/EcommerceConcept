//
//  PickerButton.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 9/12/22.
//

import SwiftUI

struct PickerButton: View {
    let itemCount: Int
    let width: CGFloat
    let height: CGFloat
    
    let minusAction: (Int) -> ()
    let plusAction: (Int) -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                minusAction(0)
            } label: {
                PickerButtonLabel(label: "-",
                                  radius: 26,
                                  corners: [.topLeft, .topRight],
                                  width: width)
            }
            
            ZStack {
                Rectangle()
                    .frame(width: 25,
                           height: width * 0.07)
                
                Text("\(itemCount)")
                    .foregroundColor(Color.white)
                    .font(.custom("MarkPro-Medium", size: 20))
            }
            
            Button {
                plusAction(0)
            } label: {
                PickerButtonLabel(label: "+",
                                  radius: 26,
                                  corners: [.bottomLeft, .bottomRight],
                                  width: width)
            }
        }
        .foregroundColor(Color("DarkGray"))
    }
}

struct PickerButton_Previews: PreviewProvider {
    static var previews: some View {
        PickerButton(itemCount: 1,
                     width: 414,
                     height: 896,
                     minusAction: { _ in },
                     plusAction: { _ in })
    }
}
