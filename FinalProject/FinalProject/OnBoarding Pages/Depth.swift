//
//  Depth.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct Depth: View {
    @State var bool = false
    var body: some View {
        VStack{
        GeometryReader{ proxy in
            VStack{
                if proxy.size.width < proxy.size.height{
                    self.verticalContent()
                }else{
                    self.horizontalContent()
                }
                
                
            }
            
        }
        .background(Color("pastelOnBoarding")).edgesIgnoringSafeArea(.all)
    }
    }
    func verticalContent() -> some View{
        VStack{
            
            Text("Instrumentation")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("accent"))
                .padding(.bottom)
            Text("Depth:")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(self.bool ? .red : Color("accent"))
                .frame(width: 300 * 0.65)
                .padding(.bottom)
            Text("1")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(Color("accent"))
                .frame(width: 300 * 0.25, alignment: .trailing)
                .fixedSize(horizontal: true, vertical: false)
                .background(
                    Color("pastelSimulation")
                        .frame(width: 300 * 0.25, height: 31.0, alignment: .center)
                        .fixedSize(horizontal: true, vertical: true)
            )
            Text("The Depth counter will output a number of how many times the same grid pattern has occured. ")
                .bold()
                .frame(width: 300, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
            
            
        }
    }
    func horizontalContent() -> some View {
        VStack{
            
            Text("Instrumentation")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("accent"))
                .padding(.bottom)
                .padding(.top, -50)
            Text("Depth:")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(self.bool ? .red : Color("accent"))
                .frame(width: 300 * 0.65)
                .padding(.bottom)
            Text("1")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(Color("accent"))
                .frame(width: 300 * 0.25, alignment: .trailing)
                .fixedSize(horizontal: true, vertical: false)
                .background(
                    Color("pastelSimulation")
                        .frame(width: 300 * 0.25, height: 31.0, alignment: .center)
                        .fixedSize(horizontal: true, vertical: true)
            )
            Text("The Depth counter will output a number of how many times the same grid pattern has occured. ")
                .bold()
                .frame(width: 300, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
            
            
        }
    }
}

struct Depth_Previews: PreviewProvider {
    static var previews: some View {
        Depth()
    }
}
