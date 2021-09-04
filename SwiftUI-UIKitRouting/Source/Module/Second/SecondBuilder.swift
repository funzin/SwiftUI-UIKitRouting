//
//  SecondBuilder.swift
//  SwiftUI-Routing
//
//  Created by funzin on 2021/09/04.
//

import Combine
import SwiftUI
import UIKit

enum SecondBuilder {
    static func build() -> UIViewController {
        let view = SecondView()
        let vc = UIHostingController(rootView: view)
        vc.title = "Second"
        return vc
    }
}
