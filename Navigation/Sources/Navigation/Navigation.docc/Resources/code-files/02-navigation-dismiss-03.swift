//
//  02-navigation-dismiss-03.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI
import Navigation

struct DetailView: View {

    @StateObject private var navigation: Navigation = .init()

    var body: some View {
        NavigationView {
            Button {
                navigation.present(.push) {
                    BlueView()
                }
            } label: {
                Text("push to #2 page")
                    .padding()
                    .border(Color.green)
            }
            .uses(navigation)
            .navigationTitle("Detail View - Page #1")
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
