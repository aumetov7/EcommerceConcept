//
//  MainScreenView.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack(alignment: .center) {
                        Text("Select Category")
                            .font(.custom("MarkPro-Bold", size: 25))
                        
                        Spacer()
                        
                        Button {
                            // View all action
                        } label: {
                            Text("view all")
                                .font(.custom("MarkPro", size: 15))
                                .foregroundColor(Color("Orange"))
                        }
                        .padding(.trailing)
                    }
                    .padding(.horizontal)
                    
                    CategoryView(categoryVM: categoryVM, height: geometry.size.height * 0.14)
                        .padding(.horizontal)
                    
                    SearchBarView(searchText: $searchText)
                        .padding([.horizontal, .top])
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Button {
                            // Location action
                        } label: {
                            HStack(spacing: 10) {
                                Image("locationIcon")
                                    .resizedToFill(width: geometry.size.width * 0.02,
                                                   height: geometry.size.height * 0.02)
                                
                                Text("Zihuatanejo, Gro")
                                    .font(.custom("MarkPro-Medium", size: 15))
                                    .foregroundColor(.black)
                                
                                Image(systemName: "chevron.down")
                                    .font(.custom("MarkPro", size: 12))
                                    .foregroundColor(.black.opacity(0.2))
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // Filter action
                        } label: {
                            Image("filterIcon")
                                .resizedToFill(width: geometry.size.width * 0.02,
                                               height: geometry.size.height * 0.02)
                        }
                        .padding(.trailing)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color("BackgroundColor"))
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
