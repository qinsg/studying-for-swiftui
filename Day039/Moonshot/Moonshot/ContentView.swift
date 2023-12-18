//
//  ContentView.swift
//  Moonshot
//
//  Created by James Qin on 2023/12/15.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            Image(.example)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal){size, axis in
                    size * 0.8
                }
//                .frame(width: 300, height: 300)
//                .clipped()
        }
    }
}

struct ScrolledView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 10){
                ForEach(0..<100) {
                    Text("Item \($0)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    init(_ text: String) {
        print("Creating a new CustomText: \(text)")
        self.text = text
    }
}

struct VerticalScrollerView: View {
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10){
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

struct HorizontalScrollerView: View {
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack(spacing: 10){
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ComplicatedView:View {
    var body: some View {
        NavigationStack {
            NavigationLink{
                Text("Detail View")
            } label: {
                VStack{
                    Text("This is the label")
                    Text("So is this")
                    Image(.example)
                        .resizable()
                }
                .font(.largeTitle)
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct ListNavigationLinkView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct DecodeJsonView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
        {
            "name": "Taylor Swift",
            "address": {
                "street": "555, Taylor Swift Avenue",
                "city": "Nashville"
            }
        }
        """
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data){
                print(user.address.street)
            }
        }
        
    }
}

struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
        GridItem(.adaptive(minimum: 80, maximum: 120)),
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

#Preview {
    // ContentView()
    HorizontalScrollerView()
}
