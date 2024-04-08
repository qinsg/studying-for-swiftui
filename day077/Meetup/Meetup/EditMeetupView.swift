//
//  EditMeetupView.swift
//  Meetup
//
//  Created by James Qin on 2024/3/25.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct EditMeetupView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @State private var name: String = ""
    
    var body: some View {
        VStack{
            Form{
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus")
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                TextField("Please input the name:", text: $name)
                Button("Save") {
                    
                }
            }
        }
        
    }
    
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
//            let beginImage = CIImage(image: inputImage)
//            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
//            
//            guard let outputImage = currentFilter.outputImage else { return }
//            guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
//
//            let uiImage = UIImage(cgImage: cgImage)
            // processedImage = Image(uiImage: uiImage)
            processedImage = Image(uiImage: inputImage)
        }
    }
    
    func applyProcessing() {
        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    EditMeetupView()
}
