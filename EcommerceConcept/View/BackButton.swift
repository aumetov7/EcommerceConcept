//
//  BackButton.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

struct BackButton: View {
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.custom("MarkPro-Medium", size: 20))
                .padding(8)
                .foregroundColor(Color.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("DarkPurple"))
                        .frame(width: 40, height: 40)
                }
        }
    }
}
