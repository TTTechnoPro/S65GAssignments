//
//  InstrumentationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 7/11/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
//
//  InstrumentationView.swift
//  GameOfLife
//
//  Created by Van Simmons on 9/12/19.
//  Copyright © 2019 Van Simmons. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Simulation
import FunctionalProgramming

fileprivate let formatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.maximumFractionDigits = 3
    return nf
}()

struct InstrumentationView: View {
    let store: Store<SimulationState, SimulationState.Action>
    private var width: CGFloat

    init(
        store: Store<SimulationState, SimulationState.Action>,
        width: CGFloat = 250.0
    ) {
        self.store = store
        self.width = width
    }

    var body: some View {
        VStack {
            Spacer()
            control1(width)
                .padding(.top, 10.0)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control2(width)
                .padding(.top, -3.0)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control3(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control4(width)
                .padding(.top, -3.0)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            buttons
                .frame(width: width, alignment: .top)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.bottom, 5.0)
            Spacer()
        }
    }

    func control1(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 6 code replaces the following line
                Text("Size : \(viewStore.gridState.grid.size.rows)")
                .bold()
                    .font(.system(size: 12.0))
                    .frame(width: 90, alignment: .leading)
                    .foregroundColor(Color("accent"))
                
                Spacer()
                
                Text("Depth")
                    .bold()
                    .font(.system(size: 12.0))
                    .frame(width: 70, alignment: .trailing)
                    .foregroundColor(Color("accent"))
                    .padding(.trailing, 5.0)
            }
        }
    }

    func control2(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 7 code replaces the following line
                Slider(
                    value: viewStore.binding(
                        get: { Double($0.gridState.grid.size.rows) },
                        send: {.setGridSize(Int($0)) }
                    ),
                    in: 5 ... 40,
                    step: 1,
                    onEditingChanged: { _ in },
                    minimumValueLabel: Text("5").font(.system(size: 12.0)).foregroundColor(Color("accent")),
                    maximumValueLabel: Text("40").font(.system(size: 12.0)).foregroundColor(Color("accent")),
                    label: {Spacer()}
                ).accentColor(Color("accent"))
                    .frame(width: 160.0)
                Spacer()
                Text("\(self.cycleLength(for: viewStore))")
                    .font(.system(size: 12.0))
                    .frame(width: 70, alignment: .trailing)
                    //.background(Color.white) // This is my answer for question 7.11 but this makes the text look horrible in dark mode ;-;
                    
                    // i'm gonna make a new color named "#7" and have its dark mode variant be black so it doesn't look horrible in dark mode. might as well add the accent color to the Text as well so it looks nice :)
                .background(Color("#7"))
                .foregroundColor(Color("accent"))
                .padding(.trailing, 10.0)
            }
        }
    }

    func control3(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 8 code replaces the following line
                Text("Refresh Period: \(formatter.string(from: NSNumber(value: viewStore.timerInterval)) ?? "")")
                    .bold()
                    .font(.system(size: 12.0))
                    .frame(width: 200, alignment: .leading)
                    .foregroundColor(Color("accent"))
            Spacer()
                
                Text("Simulation")
                    .bold()
                    .font(.system(size: 12.0))
                    .frame(width: 120, alignment: .leading)
                    .padding(.leading, -23.0)
                    .foregroundColor(viewStore.isRunningTimer ? Color.red : Color("accent") )
                    
            }
        }
    }

    func control4(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 9 code replaces the following line
                Slider(
                    value: viewStore.binding(
                        get: \.timerInterval,
                        send: SimulationState.Action.setTimerInterval
                    ),
                    in: 0.0 ... 1.0,
                    step: 0.1,
                    onEditingChanged: { _ in },
                    minimumValueLabel: Text("0.0").font(.system(size: 12.0)).foregroundColor(Color("accent")),
                    maximumValueLabel: Text("1.0").font(.system(size: 12.0)).foregroundColor(Color("accent")),
                    label: { Spacer() }
                ).accentColor(Color("accent"))
                .frame(width: 160.0)
                Spacer()
                Toggle(isOn: viewStore.binding(
                    get: \.isRunningTimer,
                    send: SimulationState.Action.toggleTimer
                )) {
                    EmptyView()
                    
                }.padding(.trailing, 5.0)
            }
        }
    }

    var buttons: some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 10 code replaces the following line
                ThemedButton.init(text: "Step", action: {viewStore.send(.stepGrid)})
                ThemedButton.init(text: "Empty", action: {viewStore.send(.resetGridToEmpty)})
                ThemedButton.init(text: "Random", action: {viewStore.send(.resetGridToRandom)})
            }
        }
    }

    func cycleLength(for viewStore: ViewStore<SimulationState, SimulationState.Action>) -> String {
        guard let cycleLength = viewStore.gridState.history.cycleLength else { return "" }
        return "\(cycleLength)"
    }

    func numberString(for value: Double) -> String {
        "\(formatter.string(from: NSNumber(value: value) ) ?? "")"
    }
}

struct InstrumentationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        InstrumentationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
}
