//
// NextView.swift
// LocalNotifications
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum NextView: String, Identifiable {
  case promo, renew
  var id: String {
    self.rawValue
  }
  
  @ViewBuilder
  func view() -> some View {
    switch self {
      case .promo:
        Text("Promotional Offer").font(.largeTitle)
      case .renew:
        VStack {
          Text("Renew Subscription").font(.largeTitle)
          Image(systemName: "indianrupeesign.circle.fill").font(.system(size: 128))
        }
    }
  }
}
