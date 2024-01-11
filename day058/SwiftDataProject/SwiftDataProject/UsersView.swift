//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by James Qin on 2024/1/10.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List(users) { user in
            Text(user.name)
            
            Spacer()
            
            Text(String(user.jobs?.count ?? 0))
                .fontWeight(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
    
//    init(minimumJoinDate: Date) {
//        _users = Query(filter: #Predicate<User> { user in
//            user.joinDate >= minimumJoinDate
//        }, sort: \User.name)
//    }
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
