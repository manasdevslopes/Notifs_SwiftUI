//
// NotificationCentreApp.swift
// NotificationCentre
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

@main
struct NotificationCentreApp: App {
  @StateObject private var myData = AppData()
  
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(myData)
    }
  }
}
