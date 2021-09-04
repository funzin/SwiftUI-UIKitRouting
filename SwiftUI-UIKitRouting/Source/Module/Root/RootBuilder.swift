//
//  RootBuilder.swift
//  SwiftUI-Routing
//
//  Created by funzin on 2021/09/04.
//

import Combine
import SwiftUI
import UIKit

enum RootBuilder {
    static func build() -> UIViewController {
        let viewModel = RootViewModel()
        let view = RootView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        vc.title = "Top"
        viewModel.$route
            .compactMap { $0 }
            .sink(receiveValue: { [weak vc] route in
                guard let vc = vc else { return }
                switch route {
                case .first:
                    let firstVC = FirstBuilder.build()
                    let navigationController = UINavigationController(rootViewController: firstVC)
                    vc.present(navigationController, animated: true)
                case .second:
                    let secondVC = SecondBuilder.build()
                    vc.navigationController?.pushViewController(secondVC, animated: true)
                }
            })
            .store(in: &viewModel.cancellables)
        return vc
    }
}
