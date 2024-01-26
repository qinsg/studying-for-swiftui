//
//  FileManager-Ext.swift
//  BucketList
//
//  Created by James Qin on 2024/1/26.
//

import Foundation

extension FileManager {
    func save(_ data: Data) -> Bool {
        // let data = Data("Test Message; 测试".utf8)
        let url = URL.documentsDirectory.appending(path: "message.txt")
        
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection ])
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    func read() -> String {
        let url = URL.documentsDirectory.appending(path: "message.txt")
        var data: String = ""
        do {
            data = try String(contentsOf: url)
        }catch {
            print(error.localizedDescription)
        }
        return data
    }
}
