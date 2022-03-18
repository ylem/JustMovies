//
//  02-navigation-dismiss-06.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI
import Navigation

struct YellowView: View {

    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
        Button {
            self.rootPresentationMode.wrappedValue.dismiss()
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
