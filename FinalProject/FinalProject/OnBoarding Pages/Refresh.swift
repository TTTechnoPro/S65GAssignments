//
//  Refresh.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

fileprivate let formatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.maximumFractionDigits = 3
    return nf
}()

struct Refresh: View {
    @State var sliderValue: Double = 0.5
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
            Text("Refresh Period: \(self.numberString(for: self.sliderValue))")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent"))
                .frame(width: 300 * 0.65)
            Slider(
                value: self.$sliderValue,
                in: 0.0 ... 1.0,
                step: 0.1,
                onEditingChanged: { (changed) in },
                minimumValueLabel: Text("0.0")
                    .font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                maximumValueLabel: Text("1.0")
                    .font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                label: { Spacer() }
            )
                .frame(width: 400 * 0.65, alignment: .bottomLeading)
                .accentColor(Color("accent"))
            
            Text("The Refresh Period slider changes the time interval at which the Simulation will step (measured in seconds). ")
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
                .padding(.top,-50)
            Text("Refresh Period: \(self.numberString(for: self.sliderValue))")
                .font(.system(.headline, design: .rounded))
                .bold()
                .foregroundColor(Color("accent"))
                .frame(width: 300 * 0.65)
            Slider(
                value: self.$sliderValue,
                in: 0.0 ... 1.0,
                step: 0.1,
                onEditingChanged: { (changed) in },
                minimumValueLabel: Text("0.0")
                    .font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                maximumValueLabel: Text("1.0")
                    .font(.system(.subheadline, design: .rounded)).foregroundColor(Color("accent")),
                label: { Spacer() }
            )
                .frame(width: 400 * 0.65, alignment: .bottomLeading)
                .accentColor(Color("accent"))
            
            Text("The Refresh Period slider changes the time interval at which the Simulation will step (measured in seconds). ")
                .bold()
                .frame(width: 300, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
        }
    }
    func numberString(for value: Double) -> String {
        "\(formatter.string(from: NSNumber(value: value) ) ?? "")"
    }
}

struct Refresh_Previews: PreviewProvider {
    static var previews: some View {
        Refresh()
    }
}
