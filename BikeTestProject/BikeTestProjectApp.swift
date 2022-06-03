//
//  BikeTestProjectApp.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct BikeTestProjectApp: App {
    private let store: Store<StationListState, StationListAction> = .init(initialState: .init(stations: []),
                                                                          reducer: stationListReducer,
                                                                          environment: StationListEnvironment())
    
    var body: some Scene {
        WindowGroup {
            StationListView(store: store)
        }
    }
}
