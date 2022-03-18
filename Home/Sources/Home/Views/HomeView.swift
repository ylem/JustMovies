//
//  HomeView.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import SwiftUI
import Assets
import SwiftRedux
import CommonUI
import Models
import Navigation

struct HomeView: View {

    @EnvironmentObject private var store: HomeStore
    @State private var searchQuery: String = ""
    @State private var showDemoAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                let movies: Binding<[PopularType]> = .init(
                    get: { store.state.popularMovies },
                    set: { _  in }
                )

                let tvs: Binding<[PopularType]> = .init(
                    get: { store.state.popularTVs },
                    set: { _  in }
                )

                SearchBar(text: $searchQuery)

                PopularListView(title: "Popular Movies", items: movies)

                PopularListView(title: "Popular TVs", items: tvs)

                Spacer()
            }
        }
        .padding(.top, 32)
        .padding(.horizontal, 20)
        .background(
            gradientBackground(start: .leading, end: .trailing)
                .fillParent()
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitleDisplayMode(.inline)
    }

    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeStore.preview)
    }
}
