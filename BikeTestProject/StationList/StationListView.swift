//
//  StationListView.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import SwiftUI
import ComposableArchitecture

struct StationListView: View {
    let store: Store<StationListState, StationListAction>
    @ObservedObject private var viewStore: ViewStore<StationListState, StationListAction>
    
    init(store: Store<StationListState, StationListAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
        
        viewStore.send(.initialLoad)
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .gray.withAlphaComponent(0.1)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEachStore(store.scope(state: \.stations,
                                         action: StationListAction.stations(id:action:))) { store in
                    let stationViewStore = ViewStore(store)
                    
                    StationItemView(property: stationViewStore.station.properties)
                        .padding(.vertical, 12)
                        .listRowSeparator(.hidden)
                        .background(
                            ZStack {
                                NavigationLink("", destination: StationView(store: store)).opacity(0)
                                Color.white
                                    .cornerRadius(8)
                                    .shadow(color: .gray.opacity(0.3), radius: 3, x: 1, y: 1)
                            }
                        )
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
    
}

struct StationItemView: View {
    var isNameShown: Bool = true
    let property: StationJSONModel.Station.Property
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            if isNameShown {
                Text(property.name)
                    .font(.system(size: 34, weight: .bold))
                
                Text("Bike station")
                    .font(.body)
                    .opacity(0.6)
            }
            
            HStack {
                Spacer()
                
                VStack(spacing: 10) {
                    
                    Image("bike")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .scaledToFit()
                    
                    Text("Available bikes")
                        .font(.body)
                        .opacity(0.6)
                    
                    Text(property.bikes)
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    
                    Image("lock")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .scaledToFit()
                    
                    Text("Available places")
                        .font(.body)
                        .opacity(0.6)
                    
                    Text(property.freePlaces)
                        .font(.system(size: 70, weight: .bold))
                }
                
                Spacer()
            }
        }
        .padding(20)
    }
}


struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView(store: .init(initialState: .init(stations: []),
                                  reducer: stationListReducer,
                                  environment: StationListEnvironment()))
    }
}
