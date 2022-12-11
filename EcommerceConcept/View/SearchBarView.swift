//
//  SearchBarView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .trailing) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color("Orange"))
                                .font(.custom("MarkPro", size: 15))
                                .padding(.leading)
                            
                            TextField("", text: $searchText)
                                .placeholder(when: searchText.isEmpty) {
                                    Text("Search")
                                        .font(.custom("MarkPro", size: 12))
                                        .foregroundColor(.gray)
                                }
                                .font(.custom("MarkPro", size: 12))
                                .accentColor(.gray)
                        }
                        
                        if searchText.count > 0 {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color.white)
                }
            
            Button {
                // qrCode action
            } label: {
                Image("qrCodeIcon")
                    .resizedToFill(width: 15, height: 15)
                    .foregroundColor(Color.white)
                    .padding(8)
                    .background {
                        Circle()
                            .foregroundColor(Color("Orange"))
                    }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
