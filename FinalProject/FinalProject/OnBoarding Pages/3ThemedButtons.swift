//
//  3ThemedButtons.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct _ThemedButtons: View {
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                Text("Instrumentation")
                    .bold()
                    .font(.largeTitle)
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("accent"))
                    .padding(.bottom)
                HStack{
                    ThemedButton(text: "Step") {}.frame(width: 120, height: 100)
                    Spacer()
                    Text("This will step the grid to its next state, using the Game of Life Rules. An animation will also play.")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .foregroundColor(.black)
                    
                }.padding(.bottom)
                HStack{
                    ThemedButton(text: "Empty") {}.frame(width: 120, height: 100)
                    Spacer()
                    Text("This will reset the grid and there will be no cells.")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .foregroundColor(.black)
                    
                }.padding(.bottom)
                HStack{
                    ThemedButton(text: "Random") {}.frame(width: 120, height: 100)
                    Spacer()
                    Text("This will reset the grid and set a random number of cells to the \"alive\" state.")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .foregroundColor(.black)
                }
                
                
                
            }
            
        }
        .background(Color("pastelOnBoarding")).edgesIgnoringSafeArea(.all)
    }
}

struct _ThemedButtons_Previews: PreviewProvider {
    static var previews: some View {
        _ThemedButtons()
    }
}
