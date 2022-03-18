//
//  HomeRoute.swift
//  
//
//  Created by Wei Lu on 18/03/2022.
//

import SwiftUI
import Navigation
import Models

enum HomeRoute: Navigating {
    case detail(PopularType)

    @ViewBuilder func view() -> some View {
        switch self {
        case .detail(let item):
            PopularDetailsView(item: item)
        }
    }
}
