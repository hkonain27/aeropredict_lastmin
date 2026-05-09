//
//  StorageManager.swift
//  AeroPredict
//
//  Created by Hafsa Konain on 4/2/26.
//
import Foundation

class StorageManager {
    static let shared = StorageManager()
    private init() {}

    private let key = "savedFlights"

    func saveFlights(_ flights: [FlightPrediction]) {
        if let data = try? JSONEncoder().encode(flights) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadFlights() -> [FlightPrediction] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let flights = try? JSONDecoder().decode([FlightPrediction].self, from: data) else {
            return []
        }
        return flights
    }
}
