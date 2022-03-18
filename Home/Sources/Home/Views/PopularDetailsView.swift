//
//  PopularDetailsView.swift
//  
//
//  Created by Wei Lu on 18/03/2022.
//

import SwiftUI
import Models
import CommonUI
import Networking
import Assets

struct PopularDetailsView: View {

    private let item: PopularType

    init(item: PopularType) {
        self.item = item
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AsyncImage(url: item.posterImageURL(width: .w780)) {
                    ProgressView()
                } image: { image in
                    Image(uiImage: image)
                        .resizable()
                }
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width)
                .overlay (
                    LinearGradient(gradient:
                                    Gradient(colors: [
                                        Color(AppColor.background.color).opacity(0.1),
                                        Color(AppColor.background.color),
                                    ]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )

                VStack(spacing: 16) {
                    Text(item.displayName)
                        .foregroundColor(.white)
                        .font(.title.weight(.bold))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)

                    Label(title: {
                        Text(item.vate)
                            .foregroundColor(Color(AppColor.textPrimary.color))
                            .font(.subheadline)
                    }, icon: {
                        Image(uiImage: AppImage.star.image)
                            .resizable()
                            .frame(width: 12, height: 12)
                    })

                    if let movie: Movie = item as? Movie {
                        Text(movie.releaseDate)
                            .foregroundColor(.white)
                            .font(.caption)
                    } else if let tv: TV = item as? TV {
                        Text(tv.firstAirDate)
                            .foregroundColor(.white)
                            .font(.caption)
                    }

                    Text(item.overview)
                        .foregroundColor(.white)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)

                }
                .padding(.horizontal, 24)
                .padding(.bottom, 60)
            }
        }
        .background(
            Color(AppColor.background.color)
        )
        .fillParent()
        .edgesIgnoringSafeArea(.all)
    }
}
