//
//  FilterView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var price = PriceViewModel()
    @StateObject private var brand = BrandViewModel()
    
    @State private var brandIsExpanded = false
    @State private var priceIsExpanded = false
    @State private var sizeIsExpanded = false
    
    @Binding var showMenu: Bool
    
    let width: CGFloat
    let height: CGFloat
    
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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .trailing) {
                    HStack(alignment: .center) {
                        Spacer()
                            .overlay(alignment: .leading) {
                                Button {
                                    showMenu = false
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.custom("MarkPro-Medium", size: 18))
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color("DarkPurple"))
                                        }
                                }
                            }
                        
                        Text("Filter options")
                            .font(.custom("MarkPro-Medium", size: 18))
                        
                        Spacer()
                            .overlay(alignment: .trailing) {
                                Button {
                                    showMenu = false
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Done")
                                        .font(.custom("MarkPro-Medium", size: 18))
                                        .foregroundColor(.white)
                                        .padding([.top, .bottom], 8)
                                        .padding(.horizontal)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color("Orange"))
                                        }
                                }
                            }
                    }
                    .padding(.horizontal)
                    .padding([.top, .bottom], 6)
                }
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Brand")
                            .font(.custom("MarkPro-Medium", size: 18))
                        
                        CustomDisclosureGroup(animation: .easeInOut(duration: 0.2), isExpanded: $brandIsExpanded) {
                            brandIsExpanded.toggle()
                        } prompt: {
                            HStack {
                                Text(brand.selectedBrand)
                                    .font(.custom("MarkPro", size: 18))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .rotationEffect(brandIsExpanded ? Angle(degrees: 180) : .zero)
                            }
                            .padding([.top, .bottom], 8)
                            .padding(.horizontal)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            })
                            .padding(.bottom)
                        } expandedView: {
                            VStack(alignment: .leading) {
                                ForEach(brand.brand, id: \.self) { element in
                                    Button {
                                        brand.selectBrand(brand: element)
                                        brandIsExpanded.toggle()
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
                    
                    VStack(alignment: .leading) {
                        Text("Price")
                            .font(.custom("MarkPro-Medium", size: 18))
                        
                        CustomDisclosureGroup(animation: .easeInOut(duration: 0.2), isExpanded: $priceIsExpanded) {
                            priceIsExpanded.toggle()
                        } prompt: {
                            disclosureGroupPrompt(isExpanded: priceIsExpanded,
                                                  item: "$\(getValue(val: price.minValue)) - $\(getValue(val: price.maxValue))")
                        } expandedView: {
                            VStack(alignment: .leading) {
                                RangeSliderView(price: price, width: width)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .font(.custom("MarkPro", size: 18))
                        }
                    }
                    
                    FilterMenuView(isExpanded: $sizeIsExpanded, title: "Size", item: "4.5 to 5.5 inches")
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
    
    func getValue(val: CGFloat) -> String {
        return String(format: "%.0f", val.rounded())
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(showMenu: .constant(true), width: 414, height: 896)
    }
}