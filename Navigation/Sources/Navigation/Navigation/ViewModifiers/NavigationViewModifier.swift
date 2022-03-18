//
//  NavigationViewModifier.swift
//  
//
//  Created by Wei Lu on 07/01/2022.
//

import SwiftUI

struct NavigationViewModifier: ViewModifier {

    @ObservedObject var navigation: Navigation

    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(
                    destination:
                        navigation.destination
                        .onDisappear {
                            navigation.onDismiss?()
                        },
                    isActive:
                        $navigation.isPushed,
                    label: {
                        EmptyView()
                    })
            )
            .sheet(isPresented: $navigation.isPresented, onDismiss: navigation.onDismiss) {
                navigation.destination
            }
            .fullScreenCover(isPresented: $navigation.isCovered, onDismiss: navigation.onDismiss) {
                navigation.destination
            }
    }
}

public extension View {
    func uses(_ navigation: Navigation) -> some View {
        modifier(NavigationViewModifier(navigation: navigation))
    }
}

extension UINavigationController {

    /// remove the back button title `Back` from the navigation bar.
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
