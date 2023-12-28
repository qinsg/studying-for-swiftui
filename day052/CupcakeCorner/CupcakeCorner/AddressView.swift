//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by James Qin on 2023/12/27.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    private let savePath = URL.documentsDirectory.appending(path:"SavePath")
    @State var tap: Bool = false
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                Button("Check out") {
                    tap = true
                    saveAddressToStore()
                }
                .navigationDestination(isPresented: $tap) {
                    CheckoutView(order: order)
                }
            }.disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: getAddressFromStore)
    }
    
    func getAddressFromStore() {
        print("getAddressFromStore:")
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try?
                JSONDecoder().decode(AddressStore.self, from: data) {
                order.name = decoded.name
                order.streetAddress = decoded.streetAddress
                order.city = decoded.city
                order.zip = decoded.zip
            }
        }
    }
    
    func saveAddressToStore() {
        print("Save address data")
        let data = AddressStore()
        data.name = order.name
        data.streetAddress = order.streetAddress
        data.city = order.city
        data.zip = order.zip
        
        do {
            let addressData = try JSONEncoder().encode(data)
            try addressData.write(to: savePath)
        }catch{
            print("Failed to save address data")
        }
    }
}

#Preview {
    AddressView(order: Order())
}
