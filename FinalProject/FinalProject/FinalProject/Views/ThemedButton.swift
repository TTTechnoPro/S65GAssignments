//
//  ThemedButton.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 7/12/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//


import SwiftUI

struct ThemedButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text(text)
                    .font(.system(size:13, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 68.0, height: 68.0)
            }

            // Your Problem 2 code goes here.
            .overlay(Circle().stroke(Color("accent"), lineWidth: 4.0))
            .shadow(radius: 2.0)
            Spacer()
        }
    }
}

// MARK: Previews
struct ThemedButton_Previews: PreviewProvider {
    static var previews: some View {
        ThemedButton(text: "Step") { }
    }
}
