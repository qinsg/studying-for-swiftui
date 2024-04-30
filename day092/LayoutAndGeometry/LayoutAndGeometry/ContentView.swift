//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by James Qin on 2024/4/30.
//

import SwiftUI

struct LayoutView: View {
    var body: some View {
        Text("Hello, world!")
            .padding(20)
            .background(.red)
    }
}

struct FrameView: View {
    var body: some View {
        Text("Live long and prosper")
            .frame(width: 300, height: 300, alignment: .topLeading)
            .background(.red)
    }
}

struct AlignmentView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
    }
}

struct AlignmentGuideView: View {
    var body: some View {
//        VStack(alignment: .leading){
//            Text("Hello, world.")
//            Text("This is a longer line of text")
//        }
        VStack(alignment: .leading){
            Text("Hello, world.")
                .alignmentGuide(.leading) { d in d[.trailing]}
            Text("This is a longer line of text")
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

struct HardAlignmentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading, computeValue: { dimension in
                        Double(position) * -10
                    })
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

struct CustomAlignmentGuideView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { dimension in
                        dimension[VerticalAlignment.center]
                    }
                Image(.photo)
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { dimension in
                        dimension[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world")
            //.position(x: 100, y: 100)
            .background(.red)
            .offset(x: 100, y: 100)
    }
}

#Preview {
    ContentView()
}
