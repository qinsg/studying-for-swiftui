//
//  EditProspect.swift
//  HotProspects
//
//  Created by James Qin on 2024/4/22.
//

import SwiftUI
import SwiftData

struct EditProspect: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
                .textContentType(.name)
                .font(.title)
            
            TextField("Email address", text: $prospect.emailAddress)
                .textContentType(.emailAddress)
                .font(.title)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(prospect: Prospect) {
        self.prospect = prospect
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let propest = Prospect(name: "James Qin", emailAddress: "test@test.com", isContacted: false)
        return EditProspect(prospect: propest)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
    
}
