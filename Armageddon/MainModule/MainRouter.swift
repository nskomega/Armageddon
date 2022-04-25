//
//  MainRouter.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    var presenter: UIViewController? { get set }

    func showDetailVC(meteor: NearEarthObject)
}

final class MainRouter: MainRouterProtocol {

    // MARK: Properties
    private weak var viewController: UIViewController?

    var presenter: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers
    func showDetailVC(meteor: NearEarthObject) {
//        let vc = ModuleBuilder.detailVC(meteor: meteor)
//        if let navigation = viewController?.navigationController {
//            navigation.navigationController?.modalPresentationStyle = .overCurrentContext
////            navigation.setViewControllers([vc], animated: false)
////            navigation.setNavigationBarHidden(true, animated: true)
//            viewController?.modalPresentationStyle = .overCurrentContext
//            viewController?.present(vc, animated: true)
//        }
    }
    func showBottomViewController(_ meteor: NearEarthObject) {
//        let vc = BottomSheetViewController(call: call)
//        vc.modalPresentationStyle = .overCurrentContext
//        self.presenter?.present(vc, animated: false)
    }
}
