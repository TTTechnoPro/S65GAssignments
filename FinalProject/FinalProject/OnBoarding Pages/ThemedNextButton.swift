//
//  ThemedNextButton.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct ThemedNextButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action) {
                HStack{
                    Text(text)
                        .fontWeight(.semibold)
                        .font(.title)
                    Image(systemName: "chevron.right")
                        .font(.body)
                    Image(systemName: "chevron.right")
                        .font(.body)
                    Image(systemName: "chevron.right")
                        .font(.body)
                }
                .padding()
                .foregroundColor(Color.black)
                .background(Color("accent"))
                .cornerRadius(40)
                .padding(8)
                
            }
        }
    }
}

struct ThemedNextButton_Previews: PreviewProvider {
    static var previews: some View {
        ThemedNextButton(text: "Next", action: {})
    }
}
