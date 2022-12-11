//
//  LaunchScreen.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 6/12/22.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color("Orange"))
                        .frame(width: geometry.size.width * 0.4)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Ecommerce")
                        Text("Concept")
                    }
                    .font(.custom("MarkPro-Heavy", size: 30))
                    .foregroundColor(Color.white)
                    .frame(width: geometry.size.width * 0.72,
                           alignment: .trailing)
                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .center)
        }
        .background(Color("DarkPurple"))
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
