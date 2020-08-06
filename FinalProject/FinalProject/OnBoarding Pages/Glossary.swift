//
//  Glossary.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct Glossary: View {
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                Text("Glossary")
                    .bold()
                    .font(.largeTitle)
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("accent"))
                    .padding(.bottom)
                HStack{
                    Circle()
                        .fill(Color("died"))
                        .frame(width: 100, height: 80)
                    Spacer()
                    Text("This means the cell has died")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                }.padding(.bottom)
                HStack{
                    Circle()
                        .fill(Color("empty"))
                        .frame(width: 100, height: 80)
                    Spacer()
                    Text("This means the cell is empty.")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                }.padding(.bottom)
                HStack{
                    Circle()
                        .fill(Color("born"))
                        .frame(width: 100, height: 80)
                    Spacer()
                    Text("This means the cell was born.")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                }.padding(.bottom)
                HStack{
                    Circle()
                        .fill(Color("alive"))
                        .frame(width: 100, height: 80)
                    Spacer()
                    Text("This means the cell is alive.")
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                }
                
                
                
            }
            
        }
        .background(Color("pastelOnBoarding")).edgesIgnoringSafeArea(.all)
    }
}

struct Glossary_Previews: PreviewProvider {
    static var previews: some View {
        Glossary()
    }
}
