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
                // action
            }

            itemView(title: "Present the details") {
                // action
            }

            itemView(title: "Present the details in full screen.") {
                // action
            }

            Spacer()
        }
        .uses(navigation)
        .navigationTitle("Navigation Example")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
