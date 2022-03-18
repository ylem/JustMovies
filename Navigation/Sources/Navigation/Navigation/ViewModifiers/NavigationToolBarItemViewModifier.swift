//
//  File.swift
//  
//
//  Created by Wei Lu on 13/01/2022.
//

import SwiftUI

public struct NavigationToolBarItemViewModifier: ViewModifier {

    @Environment(\.presentationMode) var presentationMode
    public let backImageTintColor: Color
    public let backImage: Image

    public init(
        backImageTintColor: Color,
        backImage: Image
    ) {
        self.backImageTintColor = backImageTintColor
        self.backImage = backImage
    }

    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            backImage
                .foregroundColor(backImageTintColor)
        }
    }

    public func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
    }
}

public extension View {

    func navigationToolBarItem(
        backImageTintColor: Color = .black,
        backImage: Image = Image(systemName: "chevron.left")
    ) -> some View {
        modifier(
            NavigationToolBarItemViewModifier(
                backImageTintColor: backImageTintColor,
                backImage: backImage
            )
        )
    }
}

/// Implement system drag gesture for Navigation child view.
extension UINavigationController: UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
