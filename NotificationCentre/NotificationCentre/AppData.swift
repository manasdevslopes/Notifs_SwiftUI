//
// AppData.swift
// NotificationCentre
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation
import SwiftUI

struct Book {
  var title: String
}

// MARK: - Model
struct BookModel: Identifiable {
  var id = UUID()
  var book: Book
}

extension Notification.Name {
  static let updateDataNotification = Notification.Name("Update Data")
}
// MARK: - View Model
class AppData: ObservableObject {
  @Published private(set) var userData: [BookModel] = []
  
  // Notification Center Publisher
  let publisher = NotificationCenter.Publisher(center: .default, name: .updateDataNotification).receive(on: RunLoop.main)
  
  func addBook(book: Book) {
    userData.append(BookModel(book: book))
    NotificationCenter.default.post(name: .updateDataNotification, object: userData.count, userInfo: nil)
  }
}
