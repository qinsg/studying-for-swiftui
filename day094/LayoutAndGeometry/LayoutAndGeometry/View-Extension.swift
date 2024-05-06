//
//  View-Extension.swift
//  LayoutAndGeometry
//
//  Created by James Qin on 2024/5/6.
//

import Foundation
import SwiftUI

extension View {
    func log(_ log: Any) -> EmptyView {
        #if DEBUG
        print("** \(log)")
        #endif
        return EmptyView()
    }
}
