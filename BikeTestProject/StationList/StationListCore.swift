//
//  StationListCore.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import Foundation
import ComposableArchitecture

struct StationListState: Equatable {
    var stations: IdentifiedArray<StationState.ID, StationState>
}

enum StationListAction {
    case initialLoad
    case updateData(with: [StationState])
    case stations(id: StationState.ID, action: StationAction)
}

struct StationListEnvironment {}

let stationListReducer = Reducer<StationListState, StationListAction, StationListEnvironment>.combine(
    stationReducer.forEach(state: \StationListState.stations,
                           action: /StationListAction.stations,
                           environment: {_ in StationEnvironment() }),
    Reducer<StationListState, StationListAction, StationListEnvironment> { state, action, env in
        switch action {
        case .initialLoad:
            let networkManager = NetworkManager.shared
            return networkManager.fetchStationsEffect.eraseToEffect()
            
        case .updateData(let stations):
            state.stations = IdentifiedArray.init(uniqueElements: stations)
            return .none
            
        case .stations:
            return .none
        }
    })
