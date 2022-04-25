//
//  DeleteViewModel.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 20.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol DeleteViewModelProtocol: AnyObject {

}

final class DeleteViewModel: DeleteViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: DeleteRouter

    init(router: DeleteRouter) {
        self.router = router
    }

    // MARK: Methods
}
