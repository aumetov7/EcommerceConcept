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
                                        .foregroundColor(Color.gray)
                                }
                                .font(.custom("MarkPro", size: 12))
                                .accentColor(Color.gray)
                        }
                        
                        if searchText.count > 0 {
                            xmarkButton
                        }
                    }
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color.white)
                }
            
            qrCodeButton
        }
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}

// MARK: - Properties

extension SearchBarView {
    var xmarkButton: some View {
        Button {
            searchText = ""
        } label: {
            Image(systemName: "xmark.circle")
                .foregroundColor(.black)
        }
    }
    
    var qrCodeButton: some View {
        Button {
            // qrCode action
        } label: {
            Image("qrCodeIcon")
                .resizedToFill(width: 15,
                               height: 15)
                .foregroundColor(Color.white)
                .padding(8)
                .background {
                    Circle()
                        .foregroundColor(Color("Orange"))
                }
        }
    }
}
