//
//  ContentView.swift
//  BucketList
//
//  Created by James Qin on 2024/1/25.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = true
    @State private var message: String?
    @State var position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
//            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//        )
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isUnlocked {
                MapReader { proxy in
                    Map(position: $position){
                    //Map(initialPosition: startPosition){
                        ForEach(viewModel.locations) {location in
        //                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                            // if you want more control over the way your markers look on the map, use an Annotation instead.
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                            .annotationTitles(.hidden)
                        }
                    }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .onMapCameraChange(frequency: .continuous) { context in
                          //print(context.region)
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
                HStack(spacing: 50) {
                    Button("London") {
                        position = MapCameraPosition.region(
//                            MKCoordinateRegion(
//                                center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
//                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                            )
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
                                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
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
            } else {
                Button("Unlock places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        // .onAppear(perform: authenticate)
    }
    
    
}

#Preview {
    ContentView()
}
