//
//  HomeRootView.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import SwiftUI
import Assets
import Navigation
import CommonUI

public struct HomeRootView: View {

    @State private var isShowingProfile: Bool = false

    public init() {}

    public var body: some View {
        HomeView()
            .onAppear {
                StoreConfig.shared.store.dispatch(.loadPopularMovies(page: 1))
                StoreConfig.shared.store.dispatch(.loadPopularTVs(page: 1))
            }
            .environmentObject(StoreConfig.shared.store)
            .accentColor(Color(AppColor.brandPrimary.color))
            .profileBarStyle(isClickedProfile: $isShowingProfile)
    }
}
