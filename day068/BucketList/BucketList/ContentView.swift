//
//  ContentView.swift
//  BucketList
//
//  Created by James Qin on 2024/1/25.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct FileReadAndWriteView: View {
    let values = [1, 5, 3, 6, 2, 9].sorted()
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Wochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(values, id: \.self) {
            Text(String($0))
        }
        List(users) { user in
            Text("\(user.firstName), \(user.lastName)")
        }
        Button("Read and Write") {
            let data = Data("Test Message; 测试".utf8)
            let isSaved = FileManager.default.save(data)
            
            if isSaved {
                let input = FileManager.default.read()
                print(input)
            }
//            let data = Data("Test Message; 测试".utf8)
//            let url = URL.documentsDirectory.appending(path: "message.txt")
//            
//            do {
//                try data.write(to: url, options: [.atomic, .completeFileProtection ])
//            //try data.write(to: url, options: [.atomic])
//                let input = try String(contentsOf: url)
//                print(input)
//            }catch{
//                print(error.localizedDescription)
//            }
        }
    }
}

struct ContentView: View {
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        Spacer()
        switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
        }
        Spacer()
        Button("Change State") {
            if loadingState == .loading {
                loadingState = .success
            } else if loadingState == .success {
                loadingState = .failed
            } else {
                loadingState = .loading
            }
        }
    }
}

#Preview {
    ContentView()
}
