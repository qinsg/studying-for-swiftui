//
//  MeView.swift
//  HotProspects
//
//  Created by James Qin on 2024/4/16.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @AppStorage("name") private var name = "Anonynous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var qrCode = UIImage()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                // Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
                    .contextMenu {
                        // let image = generateQRCode(from: "\(name)\n\(emailAddress)")
                        
//                        ShareLink(item: Image(uiImage: image), preview: SharePreview("My QR Code", image: Image(uiImage: image)))
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                // qrCode = UIImage(cgImage: cgImage)
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    
}

#Preview {
    MeView()
}
