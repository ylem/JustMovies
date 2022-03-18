//
//  02-navigation-dismiss-06.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI
import Navigation

struct YellowView: View {

    var body: some View {
        Button {
            // action
        } label: {
            Text("Pop to root #1")
                .padding()
                .border(.yellow)
        }
        .navigationBarTitle("Page #3")
    }
}

struct YellowView_Previews: PreviewProvider {
    static var previews: some View {
        YellowView()
    }
}
