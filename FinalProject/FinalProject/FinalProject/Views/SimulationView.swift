//
//  SimulationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Simulation
import Grid
import SafariServices

public struct SimulationView: View {
    let store: Store<SimulationState, SimulationState.Action>
    
    public init(store: Store<SimulationState, SimulationState.Action>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                VStack {
                    GeometryReader { g in
                        if g.size.width < g.size.height {
                            self.verticalContent(for: viewStore, geometry: g)
                        } else {
                            self.horizontalContent(for: viewStore, geometry: g)
                        }
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("Simulation")
                .navigationBarHidden(false)
                .navigationBarItems(trailing:
                    Button(action: {
                        viewStore.send(.showWiki)
                    }) {
                        Image(systemName: "questionmark.circle").font(.system(size: 20))
                    }
                )
                    .sheet(isPresented: viewStore.binding(get: \.displayWiki, send: SimulationState.Action.hideWiki)){
                        Safari()
                            .edgesIgnoringSafeArea([.bottom,.horizontal])
                }
                .background(Color("pastelSimulation")).edgesIgnoringSafeArea(.horizontal)
                    // Problem 6 - your answer goes here.
                    .onAppear{
                        if viewStore.shouldRestartTimer == true {
                            viewStore.send(.startTimer)
                            viewStore.send(.setShouldRestartTimer(false))
                        }
                }
                    .onDisappear{
                        if viewStore.isRunningTimer == true{
                            viewStore.send(.stopTimer)
                            viewStore.send(.setShouldRestartTimer(true))
                        }
                }
            }
        }
    .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func verticalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        VStack {
            Divider()
            InstrumentationView(
                store: self.store,
                width: g.size.width * 0.82
            )
                .frame(height: g.size.height * 0.38)
                .padding(.bottom, 20.0)
            
            Divider()
            
            EmptyView().modifier(
                GridAnimationModifier(store: self.store.scope(state: \.gridState, action: SimulationState.Action.grid(action:)), configuration: GridView.Configuration(),fractionComplete: viewStore.gridState.isAtStartOfAnimation ? 0.0 : 1.0))
        }
    }
    
    func horizontalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        HStack {
            Spacer()
            InstrumentationView(store: self.store)
            Spacer()
            Divider()
            EmptyView().modifier(
                GridAnimationModifier(store: self.store.scope(state: \.gridState, action: SimulationState.Action.grid(action:)), configuration: GridView.Configuration(),fractionComplete: viewStore.gridState.isAtStartOfAnimation ? 0.0 : 1.0))
                .frame(width: g.size.height)
            Spacer()
        }
    }
}

public struct SimulationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        SimulationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
}
/*
 I would like to credit and thank KavSoft for his video on SFSafariViewController
 https://www.youtube.com/watch?v=ELErI0QC1ng
 */

struct Safari: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<Safari>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: URL(string: "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life")!)
        return controller
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<Safari>) {
        
    }
}
