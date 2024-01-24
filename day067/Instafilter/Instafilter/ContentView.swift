//
//  ContentView.swift
//  Instafilter
//
//  Created by James Qin on 2024/1/22.
//
import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var filterAmount = 1.0
    @State private var filterLevels = 6.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var hasIntensity = false
    @State private var hasRadius = false
    @State private var hasScale = false
    @State private var hasAmount = false
    @State private var hasLevels = false
    
    var noImage: Bool {
        if let processedImage {
            return false
        } else {
            return true
        }
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // image area
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
                
                Spacer()
                
                if hasIntensity == true {
                    HStack{
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                            .disabled(noImage)
                    }
                    .padding(.vertical)
                }
                
                if hasRadius == true {
                    HStack{
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                            .disabled(noImage)
                    }
                    .padding(.vertical)
                }
                
                if hasScale == true {
                    HStack{
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale, applyProcessing)
                            .disabled(noImage)
                    }
                    .padding(.vertical)
                }
                if hasAmount == true {
                    HStack{
                        Text("Amount")
                        Slider(value: $filterAmount)
                            .onChange(of: filterAmount, applyProcessing)
                            .disabled(noImage)
                    }
                    .padding(.vertical)
                }
                if hasLevels == true {
                    HStack{
                        Text("Levels")
                        Slider(value: $filterLevels, in: 2...20)
                            .onChange(of: filterLevels, applyProcessing)
                            .disabled(noImage)
                    }
                    .padding(.vertical)
                }
                HStack {
                    Button("Change Filter", action: changeFilter)
                        .disabled(noImage)
                    
                    Spacer()
                    
                    // share the picture
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                // dialog here
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignetter") { setFilter(CIFilter.vignette()) }
                Button("Thermal") { setFilter(CIFilter.thermal()) }
                Button("Mask To Alpha") { setFilter(CIFilter.maskToAlpha()) }
                Button("Document Enhancer") { setFilter(CIFilter.documentEnhancer()) }
                Button("Color Posterize") { setFilter(CIFilter.colorPosterize()) }
                Button("Cancel", role: .cancel) {  }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount >= 3 {
            requestReview()
            filterCount = -100
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            // more code to come
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        // currentFilter = CIFilter.affineTile()
        //currentFilter = CIFilter.colorPosterize()
        // currentFilter.transform = 1
        let inputKeys = currentFilter.inputKeys
        print(inputKeys)
        
        hasIntensity = false
        hasRadius = false
        hasScale = false
        hasAmount = false
        hasLevels = false
        
        if inputKeys.contains(kCIInputIntensityKey) {
            hasIntensity = true
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            hasRadius = true
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            hasScale = true
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputAmountKey) {
            hasAmount = true
            currentFilter.setValue(filterAmount, forKey: kCIInputAmountKey)
            print(kCIInputAmountKey)
        }
        if inputKeys.contains("inputLevels") {
            hasLevels = true
            currentFilter.setValue(filterLevels, forKey: "inputLevels")
            print(filterLevels)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
