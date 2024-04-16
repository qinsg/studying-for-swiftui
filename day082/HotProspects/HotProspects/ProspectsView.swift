//
//  ProspectsView.swift
//  HotProspects
//
//  Created by James Qin on 2024/4/16.
//

import SwiftUI
import SwiftData

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    var count: Int {
        prospects.count
    }
    var title: String {
        switch filter {
            case .none:
                "Everyone(" + String(count) + ")"
            case .contacted:
                "Contacted(" + String(count) + ")"
            case .uncontacted:
                "Uncontacted(" + String(count) + ")"
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading, content: {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                })
            }
                .navigationTitle(title)
                .toolbar{
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name:" Paul Hudson", emailAddress: "james@gmail.com", isContacted: Bool.random())
                        modelContext.insert(prospect)
                        print("added a contact")
                    }
                }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            // That will return true if filter is equal to .contacted, or false otherwise
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
