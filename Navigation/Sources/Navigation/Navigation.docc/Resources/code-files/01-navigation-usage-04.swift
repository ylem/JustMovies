//
//  01-navigation-usage-01.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI
import Navigation

struct RootView: View {

    @StateObject private var navigation: Navigation = .init()

    private func itemView(title: String,
                          action: @escaping () -> Void) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundColor(.blue)
                    .padding()

                Spacer()

                Image(systemName: "chevron.right")
                    .renderingMode(.template)
                    .foregroundColor(Color.red)
                    .padding(.trailing)
            }

            Divider()
        }
        .background(Color.white)
        .onTapGesture {
            action()
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            itemView(title: "Push to details") {
                navigate(type: .push)
            }

            itemView(title: "Present the details") {
                navigate(type: .sheet)
            }

            itemView(title: "Present the details in full screen.") {
                navigate(type: .fullScreenCover)
            }

            Spacer()
        }
        .uses(navigation)
        .navigationTitle("Navigation Example")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func navigate(type: NavigationType) {
        navigation.present(type, destination: {
            DetailView()
        })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
