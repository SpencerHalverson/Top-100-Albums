//
//  Extensions.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/6/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {

    public static var darkGray: Color {
        Color(red: 0.367, green: 0.367, blue: 0.375)
    }

    public static var lightGray: Color {
        Color(red: 0.939, green: 0.939, blue: 0.939)
    }

    public static var itunesGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.pink, .purple, .blue]), startPoint: .leading, endPoint: .trailing)
    }
}
