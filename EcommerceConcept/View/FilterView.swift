//
//  FilterView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 7/12/22.
//

import SwiftUI

struct FilterView: View {
    @State private var brandIsExpanded = false
    @State private var priceIsExpanded = false
    @State private var sizeIsExpanded = false
    
    let height: CGFloat
    
    var body: some View {
        // To-Do close action on buttons
        
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .trailing) {
                    HStack(alignment: .center) {
                        Spacer()
                            .overlay(alignment: .leading) {
                                Button {
                                    // close action
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
                                    // done action
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
                    .padding([.top, .bottom], 5)
                }
                
                VStack {
                    FilterMenuView(isExpanded: $brandIsExpanded, title: "Brand", item: "Samsung")
                    FilterMenuView(isExpanded: $priceIsExpanded, title: "Price", item: "$300 - $500")
                    FilterMenuView(isExpanded: $sizeIsExpanded, title: "Size", item: "4.5 to 5.5 inches")
                }
                .frame(height: height * 0.48, alignment: .top)
                .padding(.horizontal)
            }
            .padding(.horizontal)
        }
        .background {
            Color.white
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(height: 896)
    }
}
