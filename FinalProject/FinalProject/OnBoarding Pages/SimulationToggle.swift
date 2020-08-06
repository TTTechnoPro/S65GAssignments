//
//  SimulationToggle.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct SimulationToggle: View {
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
    func verticalContent() -> some View {
        VStack{
            
            Text("Instrumentation")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("accent"))
                .padding(.bottom)
            Text("Simulation:")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(self.bool ? .red : Color("accent"))
                .frame(width: 300 * 0.65)
            Toggle(isOn: self.$bool){EmptyView()}.frame(width: 50, alignment: .center)
            Text("The Simulation toggle allows the Grid to step automatically. Each step interval is determined by the \"Refresh Period\" slider. The simulation will pause if another tab is opened.")
                .bold()
                .padding(.top,-50)
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
            Text("Simulation:")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(self.bool ? .red : Color("accent"))
                .frame(width: 300 * 0.65)
            Toggle(isOn: self.$bool){EmptyView()}.frame(width: 50, alignment: .center)
            Text("The Simulation toggle allows the Grid to step automatically. Each step interval is determined by the \"Refresh Period\" slider. The simulation will pause if another tab is opened.")
                .bold()
                .frame(width: 300, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
            
            
        }
    }
}

struct SimulationToggle_Previews: PreviewProvider {
    static var previews: some View {
        SimulationToggle()
    }
}
