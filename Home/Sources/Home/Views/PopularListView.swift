//
//  PopularListView.swift
//  
//
//  Created by Wei Lu on 17/03/2022.
//

import SwiftUI
import Models
import Assets
import Networking
import Navigation

struct PopularListView: View {

    var title: String
    @Binding var items: [PopularType]

    @EnvironmentObject private var store: HomeStore
    @StateObject private var navigator: Navigation = .init()

    private let screenSize: CGSize = UIScreen.main.bounds.size
    private let imageSize: PosterSize = .w342
    private let itemWidth: CGFloat = 342 / 2
    private var itemHeight: CGFloat { itemWidth * 3 / 2 }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .foregroundColor(Color(AppColor.textPrimary.color))
                    .font(.headline)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(items, id: \.id) { item in
                        popularMovieItem(item)
                            .onTapGesture {
                                store.dispatch(.show(.detail(item), navigator))
                            }
                    }
                }
            }
        }
        .uses(navigator)
    }

    private func popularMovieItem(_ item: PopularType) -> some View {
        VStack(spacing: 12) {
            AsyncImage(url: item.posterImageURL(width: .w342)) {
                ProgressView()
            } image: { image in
                Image(uiImage: image)
                    .resizable()
            }
            .scaledToFit()
            .frame(width: itemWidth, height: itemHeight)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))

            Text(item.displayName)
                .font(.subheadline)
                .foregroundColor(Color(AppColor.textPrimary.color))
                .frame(maxWidth: itemWidth)

            Label(title: {
                Text(item.vate)
                    .foregroundColor(Color(AppColor.textPrimary.color))
                    .font(.subheadline)
            }, icon: {
                Image(uiImage: AppImage.star.image)
                    .resizable()
                    .frame(width: 12, height: 12)
            })
        }
    }
}
