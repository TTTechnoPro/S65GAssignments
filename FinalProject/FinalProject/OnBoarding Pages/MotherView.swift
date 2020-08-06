//
//  MotherView.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/4/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

let store = Store(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment()
)
let contentView = ContentView(store: store)

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: viewRouter
    
    var body: some View {
        VStack{
            if viewRouter.currentPage == "SortaContentView"{
                SortaContentView()
            } else if viewRouter.currentPage == "ContentView"{
                contentView
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(viewRouter())
    }
}
