//
//  Book.swift
//  Bookworm
//
//  Created by James Qin on 2024/1/5.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String = ""
    var author: String = ""
    var genre: String = ""
    var review: String = ""
    var rating: Int = 3
    var date = Date.now
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
    
    var isValid: Bool {
        if title.isEmpty || title.trimmingCharacters(in: .whitespaces).isEmpty ||
            author.isEmpty || author.trimmingCharacters(in: .whitespaces).isEmpty ||
            genre.isEmpty || genre.trimmingCharacters(in: .whitespaces).isEmpty ||
            review.isEmpty || review.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var formateDate: String {
        date.formatted(date: .complete, time: .standard)
    }
}
