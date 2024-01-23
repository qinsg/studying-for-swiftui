//
//  ContentView.swift
//  Instafilter
//
//  Created by James Qin on 2024/1/22.
//
import PhotosUI
import SwiftUI
import StoreKit

struct SinglePhotoView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .scaledToFit()
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
        }
        .onChange(of: pickerItem) { oldValue, newValue in
            Task{
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
    
}

struct MultiPhotosView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            // PhotosPicker("Select images", selection: $pickerItems, maxSelectionCount: 3 ,matching: .images)
            // provide a completely custom label
//            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3 ,matching: .images) {
//                Label("Select images", systemImage: "photo")
//            }
            // this matches all images except screenshots
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3 ,matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select images", systemImage: "photo")
            }
        }
        .onChange(of: pickerItems) { oldValue, newValue in
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadImage)
                    }
                }
            }
        }
    }
}

struct ShareLinkView: View {
    var body: some View {
        // The simplest use
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)
        
        //you can attach a subject and message to the shared data
        // ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check out the 100 Days of SwiftUI!"))
        
        // you can customize the button itself by providing whatever label you want
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
//            Label("Spread the word about Swift", systemImage: "swift")
//        }
        // you can provide a preview to attach
        let example = Image(.example)
        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
    }
}

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
