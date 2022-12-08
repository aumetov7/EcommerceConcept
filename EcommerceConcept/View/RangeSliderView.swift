//
//  RangeSliderView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 8/12/22.
//

import SwiftUI

struct RangeSliderView: View {
    @ObservedObject var price: PriceViewModel

    var width: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(width: width * 0.75, height: 6)
                
                Rectangle()
                    .fill(Color("Orange"))
                    .frame(width: price.maxLocation - price.minLocation, height: 6)
                    .offset(x: price.minLocation)
                
                HStack(spacing: 0) {
                    Circle()
                        .fill(Color("Orange"))
                        .frame(width: 18, height: 18)
                        .offset(x: price.minLocation)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if value.location.x >= 0 && value.location.x <= price.maxLocation - 32 {
                                        price.minLocation = value.location.x
                                        price.minValue = value.location.x * 10000 / (width * 0.75)
                                    }
                                })
                        )
                    
                    Circle()
                        .fill(Color("Orange"))
                        .frame(width: 18, height: 18)
                        .offset(x: price.maxLocation - 32)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if value.location.x <= (width * 0.75) && value.location.x >= price.minLocation + 32 {
                                        price.maxLocation = value.location.x
                                        price.maxValue = value.location.x * 10000 / (width * 0.75)
                                    }
                                })
                        )
                }
            }
            
            HStack {
                Text("$\(getValue(val: price.minValue))")
                    .font(.custom("MarkPro", size: 18))
                
                Spacer()
                
                Text("$\(getValue(val: price.maxValue))")
                    .font(.custom("MarkPro", size: 18))
            }
            .frame(width: width * 0.75)
        }
        .padding([.top, .bottom], 6)
    }
    
    func getValue(val: CGFloat) -> String {
        return String(format: "%.0f", val.rounded())
    }
}

struct RangeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        RangeSliderView(price: PriceViewModel(), width: 414)
    }
}
