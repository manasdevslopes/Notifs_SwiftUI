//
// ContentView.swift
// NotificationCentre
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appData: AppData
  @State private var total: Int = 0
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          Text("Total Books:")
          Text("\(total)")
        }
        List(appData.userData) { data in
          Text(data.book.title).bold()
            .foregroundColor(Color(
              red: .random(in: 0...1),
              green: .random(in: 0...1),
              blue: .random(in: 0...1),
              opacity: 0.5
            ))
        }
        Spacer()
      }
      .padding()
      .navigationTitle("Books Count")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink(destination: AddBook()) {
            Image(systemName: "plus").tint(.primary)
          }
        }
      }
      .onReceive(appData.publisher) { notification in
        if let value = notification.object as? Int {
          self.total = value
        }
      }
      .onAppear {
        // Create instances of the Class
        let paniPuri = Snack("Pani Puri", 20)
        let coffee = Snack("Coffee", 10)
        // Post the custom Notification
        NotificationCenter.default.post(name: .customNotification, object: nil)
        
        print("I ate all items!")
        NotificationCenter.default.post(name: .randomNotification, object: nil)
      }
    }
  }
}

#Preview {
  ContentView().environmentObject(AppData())
}
