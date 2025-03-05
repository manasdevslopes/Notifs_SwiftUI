//
// AppleIcon.swift
// LocalNotifications
//
// Created by MANAS VIJAYWARGIYA on 05/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct AppleIcon: View {
  // MARK: - Properties
  var size: Double?
  var text: String = "Manas Vijaywargiya • iOS Developer • Manas Vijaywargiya • iOS Developer •".uppercased()
  var textWidth: Double = 4.9
  
  var body: some View {
    let iconSize = size ?? UIScreen.main.bounds.width
    
    ZStack {
      Color.black.ignoresSafeArea()
      ZStack {
        ForEach(Array(text.enumerated()), id: \.offset) { index, letter in
          VStack {
            Text(String(letter)).foregroundColor(.indigo)
            Spacer()
          }
          .rotationEffect(.degrees(textWidth * Double(index)))
        }
        VStack(spacing: 0) {
          Color.green
          Color.green
          Color.green
          Color.yellow
          Color.orange
          Color.red
          Color.purple
          Color.blue
        }
        .frame(width: iconSize * 4 / 5, height: iconSize * 4 / 5)
        .mask {
          Image(systemName: "applelogo")
            .resizable().scaledToFit()
        }
      }
      .frame(width: iconSize, height: iconSize)
      .font(.system(size: 15,design: .monospaced)).bold()
    }
  }
}

struct AppleIcon_Previews: PreviewProvider {
  static var previews: some View {
    AppleIcon()
  }
}
