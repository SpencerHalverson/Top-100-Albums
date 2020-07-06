//
//  ViewState.swift
//  SwiftUI Top 100
//
//  Created by Spencer Halverson on 7/3/20.
//  Copyright © 2020 Spencer Halverson. All rights reserved.
//

import Foundation

enum ViewState: Equatable {

    case loading, failed(String), ready([Album])

    var localizedString: String {
        switch self {
        case .loading:
            return NSLocalizedString("LOADING", comment: "View is loading")
        case .failed(let error):
            return NSLocalizedString("FAILED", comment: "View failed to load with error \(error)")
        case .ready:
            return NSLocalizedString("READY", comment: "View is ready")
        }
    }

    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        lhs.localizedString == rhs.localizedString
    }
}
