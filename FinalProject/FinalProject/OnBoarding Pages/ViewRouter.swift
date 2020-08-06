//
//  ViewRouter.swift
//  FinalProject
//
//  Created by Dylan Nguyen on 8/4/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import Foundation
import SwiftUI

class viewRouter: ObservableObject{
    
    @Published var currentPage: String
    
    init(){
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore"){
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "SortaContentView"
        } else {
            currentPage = "ContentView"
        }
    }
}
