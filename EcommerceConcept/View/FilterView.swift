//
//  FilterView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var price = PriceViewModel()
    @StateObject private var brand = BrandViewModel()
    
    @State private var brandIsExpanded = false
    @State private var priceIsExpanded = false
    @State private var sizeIsExpanded = false
    
    @Binding var showMenu: Bool
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .trailing) {
                    header
                    .padding(.horizontal)
                    .padding([.top, .bottom], 6)
                }
                .padding(.bottom)
                
                VStack {
                    FilterMenuView(isExpanded: $brandIsExpanded,
                                   content: ExpandedView(isExpanded: $brandIsExpanded,
                                                         buttonAction: brand.selectBrand(brand:),
                                                         items: brand.brand),
                                   title: "Brand",
                                   item: brand.selectedBrand)
                    
                    FilterMenuView(isExpanded: $priceIsExpanded,
                                   content: priceSlider,
                                   title: "Price",
                                   item: "$\(getValue(val: price.minValue)) - $\(getValue(val: price.maxValue))")
                    
                    FilterMenuView(isExpanded: $sizeIsExpanded,
                                   content: ExpandedView(isExpanded: $sizeIsExpanded,
                                                         buttonAction: { _ in },
                                                         items: []),
                                   title: "Size",
                                   item: "4.5 to 5.5 inches")
                }
                .frame(height: height * 0.48, alignment: .top)
                .padding(.horizontal)
            }
            .padding([.horizontal, .top])
        }
        .background {
            Color.white
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(showMenu: .constant(true), width: 414, height: 896)
    }
}

extension FilterView {
    @ViewBuilder
    func disclosureGroupPrompt(isExpanded: Bool, item: String) -> some View {
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
    }
    
    var closeButton: some View {
        Button {
            showMenu = false
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.custom("MarkPro-Medium", size: 18))
                .padding(8)
                .foregroundColor(Color.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("DarkPurple"))
                }
        }
    }
    
    var doneButton: some View {
        Button {
            showMenu = false
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Done")
                .font(.custom("MarkPro-Medium", size: 18))
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 8)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("Orange"))
                }
        }
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Spacer()
                .overlay(alignment: .leading) {
                    closeButton
                }
            
            Text("Filter options")
                .font(.custom("MarkPro-Medium", size: 18))
            
            Spacer()
                .overlay(alignment: .trailing) {
                    doneButton
                }
        }
    }
    
    var priceSlider: some View {
        VStack(alignment: .leading) {
            RangeSliderView(price: price, width: width)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .font(.custom("MarkPro", size: 18))
    }
}
