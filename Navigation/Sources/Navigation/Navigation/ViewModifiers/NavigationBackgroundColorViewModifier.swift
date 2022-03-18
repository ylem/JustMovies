//
//  File.swift
//  
//
//  Created by Wei Lu on 14/01/2022.
//

import SwiftUI

public struct NavigationBackgroundColorViewModifier: ViewModifier {

    private let backgroundColor: Color

    public init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    backgroundColor
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

public extension View {

    func navigationBackgroundColor(_ color: Color = .white) -> some View {
        modifier(NavigationBackgroundColorViewModifier(backgroundColor: color))
    }
}
