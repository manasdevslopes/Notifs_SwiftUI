//
// LocalNotificationsApp.swift
// LocalNotifications
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

@main
struct LocalNotificationsApp: App {
  @State private var showSplash: Bool = true
  
  @StateObject var lnManager = LocalNotificationManager()
  
  var body: some Scene {
    WindowGroup {
      ZStack {
        NotificationListView().environmentObject(lnManager)
        
        if showSplash {
          AppleIcon()
        }
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          withAnimation() {
            self.showSplash = false
          }
        }
      }
    }
  }
}
