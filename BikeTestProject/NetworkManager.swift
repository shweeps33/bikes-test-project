//
//  NetworkManager.swift
//  BikeTestProject
//
//  Created by David on 03.06.2022.
//

import Foundation
import ComposableArchitecture

class NetworkManager {
    static var shared = NetworkManager()
    
    private init() {}
    
    let fetchStationsEffect = Effect<StationListAction, Never>.future { callback in
        let url = URL(string: "https://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let stations = try? JSONDecoder().decode(StationJSONModel.self, from: data) {
                    let stationStates = stations.features.map({ StationState(id: UUID(), station: $0) })
                    DispatchQueue.main.async {
                        callback(.success(.updateData(with: stationStates)))
                    }
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
}
