//
//  ContentView-ViewModel.swift
//  Meetup
//
//  Created by James Qin on 2024/3/21.
//
import Foundation
import Observation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var meetups: [Meetup]
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                meetups = try JSONDecoder().decode([Meetup].self, from: data)
            } catch {
                meetups = []
            }
        }
    }
}
