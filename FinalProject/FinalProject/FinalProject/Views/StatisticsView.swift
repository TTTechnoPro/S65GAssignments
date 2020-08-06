//
//  StatisticsView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Statistics

public struct StatisticsView: View {
    let store: Store<StatisticsState, StatisticsState.Action>
    let viewStore: ViewStore<StatisticsState, StatisticsState.Action>

    public init(store: Store<StatisticsState, StatisticsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    public var body: some View {
        NavigationView {
            GeometryReader { g in
                VStack {
                    self.steps(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.alive(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.born(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.died(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.empty(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 12.0)

                    Button(action: {
                        self.viewStore.send(.reset)
                    }) {
                        Text("Reset")
                    }
                    .frame(alignment: .center)
                }
                .frame(width: g.size.width * 0.9, alignment: .center)
                .fixedSize(horizontal: true, vertical: false)
            }
            .navigationBarTitle(Text("Statistics"))
            .background(Color("pastelStatistics")).edgesIgnoringSafeArea(.horizontal)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: viewStore.binding(get: \.isElevenPro, send: StatisticsState.Action.sawAlready)){
            Alert(title: Text("iPhone 11 Pro Detected"), message: Text("Funny Story: I was having app crashing problems with the StatisticView Background Color only on the iPhone 11 Pro. I wanted the background color to extend beyond the \"Safe Area\" of the 11 Pro in Landscape mode and I got it to work. However, switching to another tab would result in the app crashing. Juan and I tried debugging this but we were unsuccessful. I was going to give up and throw an alert apologizing for the ugly background inconsistency. Miraculously, throwing an alert was the solution to the problem I was having!"), dismissButton: .default(Text("Enjoy that full background color in Landscape 😎")))
        }
    }

    var title: some View {
        HStack {
            Text("Statistics")
                .font(.system(size: 48))
                .bold()
                .foregroundColor(Color("accent"))
            
        }
        
    }

    func steps(width: CGFloat) -> some View {
        HStack {
            Text("Steps:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.steps)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func alive(width: CGFloat) -> some View {
        HStack {
            Text("Alive:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.alive)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func born(width: CGFloat) -> some View {
        HStack {
            Text("Born:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.born)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func died(width: CGFloat) -> some View {
        HStack {
            Text("Died:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.died)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func empty(width: CGFloat) -> some View {
        HStack {
            Text("Empty:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.empty)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.gray)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }
}

public struct StatisticsView_Previews: PreviewProvider {
    static let previewState = StatisticsState()
    public static var previews: some View {
        StatisticsView(
            store: Store(
                initialState: previewState,
                reducer: statisticsReducer,
                environment: StatisticsEnvironment()
            )
        )
    }
}
