//
//  02-navigation-dismiss-01.swift
//
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI
import Navigation

struct RootView: View {

    @StateObject private var navigation: Navigation = .init()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    navigation.present(.sheet) {
                        DetailView()
                            .environmentObject(navigation)
                    }
                } label: {
                    Text("Present a detail View")
                        .foregroundColor(.blue)
                        .padding()
                }

                Spacer()

                Image(systemName: "person.circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.red)
                    .padding(.trailing)
            }

            Divider()

            Spacer()
        }
        .uses(navigation)
        .navigationTitle("Navigation Example")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBackgroundColor(.blue)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
