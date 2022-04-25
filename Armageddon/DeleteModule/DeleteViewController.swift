//
//  DeleteViewController.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 20.04.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DeleteViewController: UIViewController {

    private var viewModel: DeleteViewModelProtocol?

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange

    }

    override func loadView() {
        super.loadView()
    }

    // MARK: Methods
    func setup(viewModel: DeleteViewModelProtocol) {
        self.viewModel = viewModel

    }
}
