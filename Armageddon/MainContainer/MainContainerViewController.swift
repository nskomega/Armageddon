//
//  MainContainerViewController.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 20.04.2022.
//

import UIKit

class MainContainerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configure()
    }

    func configure() {

        let mainView = UINavigationController.init(rootViewController: ModuleBuilder.mainVC())
        let deleteVC = ModuleBuilder.deleteVC()

        let mainVCButton = UITabBarItem(title: "Астероиды", image: UIImage(named: "web"), tag: 0) //, selectedImage: UIImage(named: "web"))
        let deleteVCButton = UITabBarItem(title: "Уничтожение", image: UIImage(named: "del"), tag: 1) //, selectedImage: UIImage(named: "del"))

        mainView.tabBarItem = mainVCButton
        deleteVC.tabBarItem = deleteVCButton

        mainView.tabBarItem.imageInsets.top = 60
        mainView.tabBarItem.imageInsets.bottom = 60
        deleteVC.tabBarItem.imageInsets.top = 60
        deleteVC.tabBarItem.imageInsets.bottom = 60

        self.viewControllers = [mainView, deleteVC]

    }

}

extension MainContainerViewController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false
        }
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionFlipFromLeft], completion: nil)
        }
        return true
    }
}
