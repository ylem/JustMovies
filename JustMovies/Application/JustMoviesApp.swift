//
//  JustMoviesApp.swift
//  JustMovies
//
//  Created by Wei Lu on 15/03/2022.
//

import SwiftUI
import Home
import Assets

@main
struct JustMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            HomeContainerView()
                .accentColor(Color(AppColor.brandPrimary.color))
        }
    }
}
