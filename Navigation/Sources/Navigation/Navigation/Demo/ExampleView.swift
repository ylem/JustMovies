//
//  ExampleView.swift
//  
//
//  Created by Wei Lu on 07/01/2022.
//

import SwiftUI

struct ExampleView: View {

    @StateObject private var navigation: Navigation = .init()

    @State private var toggleTitle: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Rectangle()
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.red)

                Button {
                    showDetail(.push)
                } label: {
                    Text("Push to next page")
                        .foregroundColor(.green)
                }

                Button {
                    showDetail(.sheet)
                } label: {
                    Text("sheet next page")
                }

                Button {
                    showDetail(.fullScreenCover)
                } label: {
                    if toggleTitle {
                        Text("fullscreen next page")
                    } else {
                        Text("dismissed fullscreen page")
                    }
                }

                Spacer()
            }
            .navigationBarTitle("Navigation Demo")
            .uses(navigation)
            .navigationBackgroundColor(.blue)
        }
    }

    private func showDetail(_ type: NavigationType) {
        navigation.present(type,
                           destination: {
            ExampleDetailView()
        }, onDismiss: {
            if type == .fullScreenCover {
                toggleTitle.toggle()
            }
        })
    }
}

struct ExampleDetailView: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 16) {
            Text("Hello")
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Close")
                    .foregroundColor(Color.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 60)
                    .background(Color.blue)
            }
        }
        .navigationBarTitle("detail title", displayMode: .inline)
        .navigationToolBarItem(backImageTintColor: .green)
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()

        ExampleDetailView()
    }
}
