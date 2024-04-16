//
//  ContentView.swift
//  HotProspects
//
//  Created by James Qin on 2024/4/8.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct SimpleView: View {
    
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Send message", systemImage: "message") {
                        print("Hi")
                    }
                }
        }

    }
}

struct SwipeView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deleting")
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button("Send message", systemImage: "message") {
                        print("Hi")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct NotificationView: View {
    var body: some View {
        VStack {
            Spacer()
            Button("Request Permission") {
                // step first
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            Spacer()
            Button("Schedule Notification") {
                // step second
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
                print("Notification added.")
            }
            Spacer()
        }
    }
}

struct ContentView: View {
    let possibleNumbers = 1...60
    
    var results: String {
        // more code to come
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    var body: some View {
        Text(results)
    }
}

#Preview {
    ContentView()
}
