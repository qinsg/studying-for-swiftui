//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by James Qin on 2024/2/21.
//

import Foundation
import MapKit
import LocalAuthentication
import Observation

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = true
        var errTitle = ""
        var message: String?
        var isError = false
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else {return}
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }catch{
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        // authenticated successfully
                        self.isUnlocked = true
                        self.isError = false
                    } else {
                        // there was a problem
                        self.isError = true
                        self.errTitle = "Failed"
                        self.message = authenticationError?.localizedDescription
                    }
                }
            } else {
                // no biometrics
                self.isError = true
                self.errTitle = "Don't Support"
                self.message = "This device hasn't biometrics"
            }
        }
    }
}
