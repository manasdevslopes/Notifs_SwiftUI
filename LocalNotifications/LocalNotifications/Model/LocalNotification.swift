//
// LocalNotification.swift
// LocalNotifications
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation

struct LocalNotification {
  enum ScheduleType {
    case time, calendar
  }
  
  var identifier: String
  var title: String
  var body: String
  var subtitle: String?
  var timeInterval: Double?
  var dateComponents: DateComponents?
  var repeats: Bool
  var scheduleType: ScheduleType
  var bundleImageName: String?
  var userInfo: [AnyHashable: Any]?
  var categoryIdentifier: String?
  
  internal init(identifier: String, title: String, body: String, timeInterval: Double, repeats: Bool) {
    self.identifier = identifier
    self.title = title
    self.body = body
    self.timeInterval = timeInterval
    self.dateComponents = nil
    self.repeats = repeats
    self.scheduleType = .time
  }
  
  internal init(identifier: String, title: String, body: String, dateComponents: DateComponents, repeats: Bool) {
    self.identifier = identifier
    self.title = title
    self.body = body
    self.timeInterval = nil
    self.dateComponents = dateComponents
    self.repeats = repeats
    self.scheduleType = .calendar
  }
}
