//
//  02-navigation-dismiss-05.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI
import Navigation

struct BlueView: View {

    @StateObject private var navigation: Navigation = .init()

    var body: some View {
        Button {
            navigation.present(.push) {
                YellowView()
            }
        } label: {
            Text("Push to #3 page")
                .padding()
                .border(Color.blue)
        }
        .uses(navigation)
        .navigationTitle("Page #2")
    }
}

struct BlueView_Previews: PreviewProvider {
    static var previews: some View {
        BlueView()
    }
}
