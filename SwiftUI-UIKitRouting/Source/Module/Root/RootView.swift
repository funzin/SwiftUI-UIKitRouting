//
//  RootView.swift
//  SwiftUI-Routing
//
//  Created by funzin on 2021/09/04.
//

import SwiftUI

struct RootView: View {
    let viewModel: RootViewModel

    var body: some View {
        VStack(spacing: 16) {
            Button("First") {
                viewModel.didTapFirstButton.send(())
            }
            Button("Second") {
                viewModel.didTapSecondButton.send(())
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init())
    }
}
