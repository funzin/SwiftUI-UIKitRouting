## Overview
This repository that describes UIKit routing when using both SwiftUI View and UIViewController

## Folder Structure
This project contains UIKit ViewControler and SwiftUI View.
```
SwiftUI-UIKitRouting/Source/Module
├── First // UIKit base
│   ├── FirstBuilder.swift
│   └── FirstViewController.swift
├── Root // SwiftUI Base
│   ├── RootBuilder.swift
│   ├── RootRoute.swift
│   ├── RootView.swift
│   └── RootViewModel.swift
└── Second // Swift UIBase
    ├── SecondBuilder.swift
    └── SecondView.swift
```

## Motivation
- I would like to use both UIKit ViewController and SwiftUI View
- Don't use `NavigationLink` for screen transitions

## Routing 
I focus on ViewModel and Builder

- ViewModel: Manage the logic that SwiftUI View depends
- Builder: Resolve dependencies and return UIViewController

### ViewModel
```swift
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
```
- `route` is published to handle with Builder

### Builder
```swift
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
                    // UIKit module
                    let firstVC = FirstBuilder.build()
                    let navigationController = UINavigationController(rootViewController: firstVC)
                    vc.present(navigationController, animated: true)
	
                case .second:
                    // SwiftUIView module
                    let secondVC = SecondBuilder.build()
                    vc.navigationController?.pushViewController(secondVC, animated: true)
                }
            })
            .store(in: &viewModel.cancellables)
        return vc
    }
}

enum FirstBuilder {
    static func build() -> UIViewController {
        let vc = FirstViewController(nibName: nil, bundle: nil)
        vc.title = "FirstViewController"
        return vc
    }
}

enum SecondBuilder {
    static func build() -> UIViewController {
        let view = SecondView()
        let vc = UIHostingController(rootView: view)
        vc.title = "Second"
        return vc
    }
}
```

- Transition is based on UIKit(e.g. `present` or `pushViewController`)
  - If you use SwiftUI view(e.g. Second module), wrap SwiftUI View as UIHostingController
  - If you use UIKit ViewController(e.g. First module), you use it directory
