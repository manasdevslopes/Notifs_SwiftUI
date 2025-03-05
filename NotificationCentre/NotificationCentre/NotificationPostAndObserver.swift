//
// NotificationPostAndObserver.swift
// NotificationCentre
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import UIKit


// Define custom notification names
extension Notification.Name {
  static let customNotification = Notification.Name("com.example.customNotification")
  static let randomNotification = Notification.Name("com.example.randomNotification")
}

// Define a class that will observe the notifications
final class Snack {
  let name: String
  let qty: Int
  
  init(_ name: String, _ qty: Int) {
    self.name = name
    self.qty = qty
    // One way
    addObserver()
    // Other way
    // addObserver1()
  }
  deinit { NotificationCenter.default.removeObserver(self) }
  
  func printDescription() {
    print("We have \(qty) \(name)\(qty > 1 ? "s" : "")")
  }
}

// MARK: - Notification Observer
extension Snack {
    func addObserver() {
      NotificationCenter.default.addObserver(forName: .customNotification, object: nil, queue: .main) { [weak self] notification in
        guard let self = self else { return }
        self.printDescription()
      }
    }
  
  private func addObserver1() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .customNotification, object: nil)
  }
  @objc private func handleNotification() {
    printDescription()
  }
}
