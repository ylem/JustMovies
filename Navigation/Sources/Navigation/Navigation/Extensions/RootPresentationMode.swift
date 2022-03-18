//
//  File.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI


/// using for Auth presenting view (should be only used in ``MainApp\NavigationViewModifier``)
struct AuthPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

public extension EnvironmentValues {
    var authPresentationMode: Binding<RootPresentationMode> {
        get { return self[AuthPresentationModeKey.self] }
        set { self[AuthPresentationModeKey.self] = newValue }
    }
}


struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

public extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

public typealias RootPresentationMode = Bool

public extension RootPresentationMode {

    mutating func dismiss() {
        self.toggle()
    }
}
