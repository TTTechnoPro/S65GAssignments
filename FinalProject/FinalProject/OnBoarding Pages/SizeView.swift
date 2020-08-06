//
//  SizeView.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct SizeView: View {
    @State var sliderValue: Double = 10
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
    func verticalContent () ->  some View {
        VStack{
            Text("Instrumentation")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("accent"))
                .padding(.bottom)
            Text("Size: \(Int(self.sliderValue))")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent"))
                .frame(width: 300 * 0.65)
            Slider(
                value: self.$sliderValue,
                in: 5 ... 40,
                step: 1,
                onEditingChanged: { (changed) in },
                minimumValueLabel: Text("5").font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                maximumValueLabel: Text("40").font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                label: { Spacer() }
            )
                .frame(width: 400 * 0.65, alignment: .bottomLeading)
                .accentColor(Color("accent"))
            
            Text("The Size slider changes the size of the Grid. When the Simulation toggle is enabled, this slider is disabled. ")
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
            Text("Size: \(Int(self.sliderValue))")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent"))
                .frame(width: 300 * 0.65)
            Slider(
                value: self.$sliderValue,
                in: 5 ... 40,
                step: 1,
                onEditingChanged: { (changed) in },
                minimumValueLabel: Text("5").font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                maximumValueLabel: Text("40").font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                label: { Spacer() }
            )
                .frame(width: 400 * 0.65, alignment: .bottomLeading)
                .accentColor(Color("accent"))
            
            Text("The Size slider changes the size of the Grid. When the Simulation toggle is enabled, this slider is disabled. ")
                .bold()
                .frame(width: 300, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
        }
    }
}

struct SizeView_Previews: PreviewProvider {
    static var previews: some View {
        SizeView().previewLayout(.fixed(width: 2436, height: 1125))
        //            .previewLayout(.fixed(width: 750, height: 1344))
        //            .previewLayout(.fixed(width: 2732, height: 2048))
    }
}
