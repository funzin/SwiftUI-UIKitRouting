//
//  FirstBuilder.swift
//  SwiftUI-UIKitRouting
//
//  Created by funzin on 2021/09/04.
//

import UIKit

enum FirstBuilder {
    static func build() -> UIViewController {
        let vc = FirstViewController(nibName: nil, bundle: nil)
        vc.title = "FirstViewController"
        return vc
    }
}
