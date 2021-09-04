//
//  RootViewModel.swift
//  SwiftUI-Routing
//
//  Created by funzin on 2021/09/04.
//

import Combine
import Foundation
import SwiftUI

final class RootViewModel: ObservableObject {
    let didTapFirstButton = PassthroughSubject<Void, Never>()
    let didTapSecondButton = PassthroughSubject<Void, Never>()

    var cancellables: [AnyCancellable] = []

    @Published var route: RootViewRoute?

    init() {
        Publishers
            .Merge(didTapFirstButton.map { RootViewRoute.first },
                   didTapSecondButton.map { RootViewRoute.second })
            .weakAssign(to: \.route, on: self)
            .store(in: &cancellables)
    }
}
