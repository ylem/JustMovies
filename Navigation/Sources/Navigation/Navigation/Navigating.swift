//
//  Navigating.swift
//  
//
//  Created by Wei Lu on 07/01/2022.
//

import SwiftUI

public protocol Navigating {
    associatedtype View: SwiftUI.View

    @ViewBuilder func view() -> Self.View
}
