//
//  File.swift
//  
//
//  Created by Wei Lu on 17/03/2022.
//

import SwiftUI

public extension View {

    func gradientBackground(
        start: UnitPoint = .top,
        end: UnitPoint = .bottom)
    -> some View {
        LinearGradient(gradient: Gradient(colors: [
            Color(.sRGB, red: 24/255.0, green: 23/255.0, blue: 22/255.0, opacity: 1.0),
            Color(.sRGB, red: 38/255.0, green: 35/255.0, blue: 31/255.0, opacity: 1.0),
            Color(.sRGB, red: 24/255.0, green: 23/255.0, blue: 22/255.0, opacity: 1.0),
        ]),
                       startPoint: start,
                       endPoint: end)
    }
    
}
