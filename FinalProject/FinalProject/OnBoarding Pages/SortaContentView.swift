//
//  SortaContentView.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/3/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//


/*
 I would like to credit Farukh Academy and AJ Picard for inspiring me to implement this OnBoarding View and teaching me how to implement it on the first launch!
 
 Farukh Academy Video: https://www.youtube.com/watch?v=61FxTbxrJmQ
 AJ Picard Video: https://www.youtube.com/watch?v=5_HHILEV9EU
 */
import SwiftUI
import ComposableArchitecture


struct SortaContentView: View {
    @State var SlideGesture = CGSize.zero
    @State var SlideOne = false
    @State var SlideOnePrevious = false
    @State var SlideTwo = false
    @State var SlideTwoPrevious = false
    @State var SlideThree = false
    @State var SlideThreePrevious = false
    @State var SlideFour = false
    @State var SlideFourPrevious = false
    @State var SlideFive = false
    @State var SlideFivePrevious = false
    @State var SlideSix = false
    @State var SlideSixPrevious = false
    @State var SlideSeven = false
    @State var isGlossaryDone = false
    var body: some View {
        ZStack{
            
            contentView
                .offset(x:SlideGesture.width)
                .offset(x:SlideSeven ? 0: 25000)
            

            
            if isGlossaryDone != true{
                Color("pastelOnBoarding")
                .edgesIgnoringSafeArea(.all)
            }
                
                
            Glossary()
                .offset(x: SlideGesture.width)
                .offset(x:SlideSix ? 0: 2500)
                .offset(x: SlideSeven ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideSix = true
                            self.SlideSeven = true
                            self.isGlossaryDone = true
                        }
                        if self.SlideGesture.width > 150{
                            self.SlideSixPrevious = true
                            self.SlideSix = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )
            _ThemedButtons()
                .offset(x: SlideGesture.width)
                .offset(x:SlideFive ? 0: 2500)
                .offset(x: SlideSix ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideFive = true
                            self.SlideSix = true
                        }
                        if self.SlideGesture.width > 150{
                            self.SlideFivePrevious = true
                            self.SlideFive = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )
            SimulationToggle()
                .offset(x: SlideGesture.width)
                .offset(x:SlideFour ? 0: 2500)
                .offset(x: SlideFive ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideFour = true
                            self.SlideFive = true
                        }
                        if self.SlideGesture.width > 150{
                            self.SlideFourPrevious = true
                            self.SlideFour = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )
            Depth()
                .offset(x: SlideGesture.width)
                .offset(x:SlideThree ? 0: 2500)
                .offset(x: SlideFour ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideThree = true
                            self.SlideFour = true
                        }
                        if self.SlideGesture.width > 150{
                            self.SlideThreePrevious = true
                            self.SlideThree = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )
            Refresh()
                .offset(x: SlideGesture.width)
                .offset(x:SlideTwo ? 0: 2500)
                .offset(x: SlideThree ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideTwo = true
                            self.SlideThree = true
                        }
                        if self.SlideGesture.width > 150{
                            self.SlideTwoPrevious = true
                            self.SlideTwo = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )
            SizeView()
                .offset(x: SlideGesture.width)
                .offset(x: SlideOne ? 0 : 2500)
                .offset(x: SlideTwo ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideOne = true
                            self.SlideTwo = true
                        }
                        if self.SlideGesture.width > 150{
                            self.SlideOnePrevious = true
                            self.SlideOne = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )
            Welcome()
                .offset(x: SlideGesture.width)
                .offset(x: SlideOne ? -2500 : 0)
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged { value in
                        self.SlideGesture = value.translation
                    }
                    .onEnded{ value in
                        if self.SlideGesture.width < -150{
                            self.SlideOne = true
                            self.SlideOnePrevious = false
                        }
                        self.SlideGesture = .zero
                    }
                    
            )

            
            
            VStack{
                Spacer()
                ZStack{
                    VStack{
                        ThemedNextButton(text: "Swipe", action: {}).animation(.spring()).offset(x: SlideSeven ? -2500 : 0)
                    }
                }
            }
        }
    }
    
}

struct SortaContentView_Previews: PreviewProvider {
    static var previews: some View {
        SortaContentView()
//                    .previewLayout(.fixed(width: 2436, height: 1125))
                    .previewLayout(.fixed(width: 1344, height: 750))
        //            .previewLayout(.fixed(width: 2732, height: 2048))
    }
}
