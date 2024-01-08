//
//  AddBookView.swift
//  Bookworm
//
//  Created by James Qin on 2024/1/5.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    @State private var showAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
//                Section("Write a review") {
//                    TextEditor(text: $review)
//                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6){
//                            Text(String($0))
//                        }
//                    }
//                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        // add the book
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        if newBook.isValid {
                            modelContext.insert(newBook)
                            
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                }
            }
            .navigationTitle("Add book")
            .alert("Missing information", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }message: {
                Text("All field must fill!")
            }
        }
    }
}

#Preview {
    AddBookView()
}
