//
//  StationView.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import SwiftUI
import MapKit
import ComposableArchitecture

struct StationView: View {
    let store: Store<StationState, StationAction>
    @ObservedObject private var viewStore: ViewStore<StationState, StationAction>
    
    init(store: Store<StationState, StationAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if let coordinates = CLLocationCoordinate2D(
                    latitude: viewStore.station.geometry.coordinates[1],
                    longitude: viewStore.station.geometry.coordinates[0]) {
                    ZStack(alignment: .top) {
                        StationMapView(coordinate: coordinates)
                            .frame(height: geo.size.height * 0.75, alignment: .top)
                        VStack {
                            Spacer()
                            VStack {
                                Spacer()
                                StationItemView(isNameShown: false, property: viewStore.station.properties)
                                Spacer()
                            }
                            .frame(height: geo.size.height * 0.35, alignment: .bottom)
                            .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
                        }
                        .ignoresSafeArea()
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Can't fetch location")
                        Spacer()
                    }
                }
            }
            .navigationTitle(viewStore.station.properties.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


