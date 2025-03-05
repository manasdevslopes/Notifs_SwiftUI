//
// AddBook.swift
// NotificationCentre
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct AddBook: View {
  @EnvironmentObject var appData: AppData
  @Environment(\.dismiss) var dismiss
  @State private var title: String = ""
  
  var body: some View {
    VStack {
      HStack {
        Text("Title")
        TextField("Enter Book title...", text: $title)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      HStack {
        Spacer()
        Button("Save") {
          let title = self.title.trimmingCharacters(in: .whitespacesAndNewlines)
          if !title.isEmpty {
            self.appData.addBook(book: Book(title: title))
            self.title = ""
            self.dismiss()
          }
        }
      }
      Spacer()
    }.padding()
  }
}

#Preview {
  AddBook().environmentObject(AppData())
}
