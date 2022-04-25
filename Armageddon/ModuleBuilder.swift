//
//  ModuleBuilder.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import UIKit

class ModuleBuilder {

    static func mainVC() -> UIViewController {

        let viewController = MainViewController()
        let router = MainRouter(viewController: viewController)
        router.presenter = viewController
        let networking = Networking()
        let viewModel = MainViewModel(router: router, networking: networking, handler: viewController)
        viewController.setup(viewModel: viewModel)
        viewController.view.backgroundColor = .white
        return viewController
    }

    static func deleteVC() -> UIViewController {

        let viewController = DeleteViewController()
        let router = DeleteRouter(viewController: viewController)
        router.presenter = viewController
        let viewModel = DeleteViewModel(router: router)
        viewController.setup(viewModel: viewModel)
        viewController.view.backgroundColor = .white
        return viewController
    }

    static func filterVC() -> FilterViewController {

        let viewController = FilterViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }
}
