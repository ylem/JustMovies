//
//  01-navigation-usage-05.swift
//  
//
//  Created by Wei Lu on 07/02/2022.
//

import SwiftUI

struct DetailView: View {

    var body: some View {
        VStack {
            Text("Hello there, this is a destination view of the navigation link.")
            Spacer()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 40)
    }
}

struct DetailView_Previews: PreviewProvider {

    static var previews: some View {
        DetailView()
    }
}
