//
//  StationState.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import Foundation
import ComposableArchitecture

struct StationState: Equatable, Identifiable {
    var id: UUID
    
    let station: StationJSONModel.Station
}

enum StationAction {
    case loadDistance
}

struct StationEnvironment {}

let stationReducer = Reducer<StationState, StationAction, StationEnvironment> { state, action, env in
    switch action {
    case .loadDistance:
        return .none
    }
}

