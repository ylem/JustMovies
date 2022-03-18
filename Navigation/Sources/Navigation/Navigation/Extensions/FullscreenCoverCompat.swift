//
//  FullScreenCoverCompat.swift
//  
//
//  Created by Wei Lu on 07/01/2022.
//

import SwiftUI

struct FullScreenCoverCompat<CoverContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let content: () -> CoverContent
    let dismiss: (() -> Void)?

    func body(content: Content) -> some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                content
                ZStack {
                    Color.white
                    self.content()
                }
                .offset(y: isPresented ? 0 : geo.size.height)
                .animation(.spring())
            }
            .onDisappear {
                dismiss?()
            }

        }
    }
}

extension View {
    func fullScreenCoverCompat<Content: View>(isPresented: Binding<Bool>,
                                              content: @escaping () -> Content,
                                              dismiss: (() -> Void)? = nil) -> some View {
        self.modifier(FullScreenCoverCompat(isPresented: isPresented,
                                            content: content,
                                            dismiss: dismiss))
    }
}
