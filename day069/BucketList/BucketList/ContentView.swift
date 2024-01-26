//
//  ContentView.swift
//  BucketList
//
//  Created by James Qin on 2024/1/25.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct MapView: View {
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        MapReader { proxy in
            Map(position: $position){
                ForEach(locations) {location in
                    //Marker(location.name, coordinate: location.coordinate)
                    // if you want more control over the way your markers look on the map, use an Annotation instead.
                    Annotation(location.name, coordinate: location.coordinate) {
                        Text(location.name)
                            .font(.headline)
                            .padding()
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                    .annotationTitles(.hidden)
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    print(coordinate)
                }
            }
            .onMapCameraChange(frequency: .continuous) { context in
                  //print(context.region)
              }
        }
        HStack(spacing: 50) {
            Button("London") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }
            Button("Paris") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }
            Button("Tokyo") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }
        }
    }
}

struct NoAuthenticateView: View {
    var message: String?
    
    var body: some View {
        Text("No Authenticatge.")
        Text(message ?? "Unknown Reason")
    }
}

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var message: String?
    
    var body: some View {
        VStack {
            if isUnlocked {
                MapView()
            } else {
                NoAuthenticateView(message: message)
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                    message = authenticationError?.localizedDescription
                }
            }
        } else {
            // no biometrics
            message = "This device hasn't biometrics"
        }
    }
}

#Preview {
    ContentView()
}
