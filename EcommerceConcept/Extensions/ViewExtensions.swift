//
//  ViewExtensions.swift
//  EcommerceConcept
//
//  Created by Акбар Уметов on 11/12/22.
//

import SwiftUI

extension View {
    // MARK: HalfSheet Helper
    
    func halfSheet<SheetView: View> (showSheet: Binding<Bool>,
                                     @ViewBuilder sheetView: @escaping () -> SheetView,
                                     onEnd: @escaping () -> ()) -> some View {
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(),
                                onEnd: onEnd,
                                showSheet: showSheet)
            )
    }
    
    // MARK: Different Corner Radius
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius,
                                 corners: corners) )
    }
    
    // MARK: TextField Placeholder
    
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
