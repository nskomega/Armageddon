//
//  DeleteRouter.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 20.04.2022.
//

import Foundation
import UIKit

protocol DeleteRouterProtocol: AnyObject {
    var presenter: UIViewController? { get set }
}

final class DeleteRouter: DeleteRouterProtocol {

    var presenter: UIViewController?

    // MARK: Properties
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers

}
