//
//  EditView.swift
//  BucketList
//
//  Created by James Qin on 2024/1/29.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    
//    enum LoadingState {
//        case loading, loaded, failed
//    }
//    
//    @State private var loadingState = LoadingState.loading
//    @State private var pages = [Page]()
    
//    @State private var name: String
//    @State private var description: String
    
    @State private var viewModel = ViewModel()
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                        case .loading:
                            Text("Loading...")
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(":") +
                                Text(page.description)
                                    .italic()
                            }
                        case .failed:
                            Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar{
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        viewModel.name = location.name
        viewModel.description = location.description
        // _name = State(initialValue: location.name)
        // _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // we got some data back
            let items = try JSONDecoder().decode(Result.self, from: data)
            
            viewModel.pages = items.query.pages.values.sorted()
            viewModel.loadingState = .loaded
        }catch {
            // if we're still here it means the request failed somehow
            viewModel.loadingState = .failed
        }
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
