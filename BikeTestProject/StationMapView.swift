//
//  StationMapView.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import Foundation
import SwiftUI
import MapKit

struct StationAnnotation: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct StationMapView: View {
    let coordinate: CLLocationCoordinate2D
    let locationAnnotation: [StationAnnotation]
    @State var coordinateRegion: MKCoordinateRegion
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        coordinateRegion = {
            var newRegion = MKCoordinateRegion()
            newRegion.center.latitude = coordinate.latitude
            newRegion.center.longitude = coordinate.longitude
            newRegion.span.latitudeDelta = 0.2
            newRegion.span.longitudeDelta = 0.2
            return newRegion
        }()
        
        locationAnnotation = [StationAnnotation(coordinate: coordinate)]
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $coordinateRegion,
                annotationItems: locationAnnotation) {item in
                MapPin(coordinate: item.coordinate)
            }
        }
    }
}
