//
//  MapView.swift
//  Meetup
//
//  Created by James Qin on 2024/3/22.
//

import SwiftUI
import MapKit
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct MapView: View {
    @State private var viewModel = ViewModel()
    @State private var mapStyle = MapStyle.hybrid
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            MapReader{ proxy in
                Map(initialPosition: viewModel.startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture{
                                    viewModel.selectedPlace = location
                                }
                        }
                        .annotationTitles(.hidden)
                    }
                }
                .mapStyle(mapStyle)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
            }
//            HStack(spacing: 50) {
//                Button("Add Meetup") {
//                    EditMeetupView()
//                }
//            }
        }
    }
}

#Preview {
    MapView()
}
