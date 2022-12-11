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
                ZStack {
                    Rectangle()
                        .cornerRadius(26, corners: [.topLeft, .topRight])
                        .frame(width: 25, height: width * 0.07)
                    
                    Text("-")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            ZStack {
                Rectangle()
                    .frame(width: 25, height: width * 0.07)
                
                Text("\(itemCount)")
                    .foregroundColor(.white)
                    .font(.custom("MarkPro-Medium", size: 20))
            }
            
            Button {
                plusAction(0)
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(26, corners: [.bottomLeft, .bottomRight])
                        .frame(width: 25, height: width * 0.07)
                    
                    Text("+")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }

        }
        .foregroundColor(Color("DarkGray"))
    }
}

struct PickerButton_Previews: PreviewProvider {
    static var previews: some View {
        PickerButton(itemCount: 1, width: 414, height: 896, minusAction: { _ in }, plusAction: { _ in })
    }
}
