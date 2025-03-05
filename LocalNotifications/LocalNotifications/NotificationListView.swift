//
// NotificationListView.swift
// LocalNotifications
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct NotificationListView: View {
  @EnvironmentObject var lnManager: LocalNotificationManager
  @Environment(\.scenePhase) var scenePhase
  @State private var scheduleDate = Date()
  
  var body: some View {
    NavigationStack {
      VStack {
        if lnManager.isGranted {
          GroupBox("Schedule") {
            Button("Interval Notification") {
              Task {
                var localNotification = LocalNotification(identifier: UUID().uuidString,
                                                          title: "Some Title",
                                                          body: "Some Body",
                                                          timeInterval: 10, repeats: false)
                localNotification.subtitle = "This is a subtitle"
                localNotification.bundleImageName = "Manas_Apple.jpg"
                localNotification.userInfo = ["nextView": NextView.renew.rawValue]
                localNotification.categoryIdentifier = "snooze"
                await lnManager.schedule(localNotification: localNotification)
              }
            }.buttonStyle(.bordered)
            GroupBox {
              DatePicker("", selection: $scheduleDate)
              Button("Calendar Notification") {
                Task {
                  let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduleDate)
                  let localNotification = LocalNotification(identifier: UUID().uuidString,
                                                            title: "Calendar Notification",
                                                            body: "Some Body",
                                                            dateComponents: dateComponents,
                                                            repeats: false)
                  await lnManager.schedule(localNotification: localNotification)
                }
              }.buttonStyle(.bordered)
            }
            Button("Promo Offer") {
              Task {
                let dateComponents = DateComponents(day: 1, hour: 10, minute: 0)
                var localNotification = LocalNotification(identifier: UUID().uuidString,
                                                          title: "Special Promotion",
                                                          body: "Take advantage of the monthly promotion",
                                                          dateComponents: dateComponents,
                                                          repeats: true)
                localNotification.bundleImageName = "Manas_Apple.jpg"
                localNotification.userInfo = ["nextView" : NextView.promo.rawValue]
                await lnManager.schedule(localNotification: localNotification)
              }
            }.buttonStyle(.bordered)
          }
          .frame(width: 300)
          // List of Pending Notifications Requests
          List {
            ForEach(lnManager.pendingRequests, id: \.identifier) { request in
              VStack(alignment: .leading) {
                Text(request.content.title)
                HStack {
                  Spacer()
                  Text(request.identifier).font(.caption).foregroundColor(.secondary)
                }
              }
              .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button("Delete", role: .destructive) {
                  lnManager.removeRequest(withIdentifier: request.identifier)
                }
              }
            }
          }
        } else {
          Button("Enable Notifications") {
            lnManager.openSettings()
          }.buttonStyle(.borderedProminent)
        }
        
      }
      .sheet(item: $lnManager.nextView) { nextView in
        nextView.view()
      }
      .navigationTitle("Local Notifications")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            lnManager.clearRequests()
          } label: {
            Image(systemName: "clear.fill").imageScale(.large)
          }
        }
      }
    }
    .navigationViewStyle(.stack)
    .task {
      try? await lnManager.requestAuthorization()
    }
    .onChange(of: scenePhase) { oldValue, newValue in
      if newValue == .active {
        Task {
          await lnManager.getCurrentSettings()
          await lnManager.getPendingRequests()
        }
      }
    }
  }
}

#Preview {
  NotificationListView().environmentObject(LocalNotificationManager())
}
