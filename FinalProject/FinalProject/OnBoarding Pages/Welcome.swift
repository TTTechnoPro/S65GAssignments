//
//  Welcome.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI

struct Welcome: View {
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
    
    
    
    
    
    
    
    
    
    
    func verticalContent () -> some View {
        
        VStack{
            
            Text("Welcome\nto \nGame Of Life")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                
                .foregroundColor(Color("accent"))
            Text("I would like to thank the S65G Class, Professor Ronald Van Simmons, Juan Collas, and many more for teaching me Swift, SwiftUI, and the Composable Architecture ")
                .bold()
                .frame(width: 300, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
            
        }
    }
    func horizontalContent () -> some View {
        
        HStack{
            
            Text("Welcome\nto \nGame Of Life")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.trailing,80)
                
                .foregroundColor(Color("accent"))
            Text("I would like to thank the S65G Class, Professor Ronald Van Simmons, Juan Collas, and many more for teaching me Swift, SwiftUI, and the Composable Architecture ")
                .bold()
                .frame(width: 350, height: 150)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.black)
            
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
                    .previewLayout(.fixed(width: 2436, height: 1125))
        //            .previewLayout(.fixed(width: 750, height: 1344))
        //            .previewLayout(.fixed(width: 2732, height: 2048))
    }
}
