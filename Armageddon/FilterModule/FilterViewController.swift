//
//  ViewController.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import UIKit
import SnapKit

protocol FilterViewControllerDelegate: AnyObject {
    func applyFilter(newFilter: MeteorsFilter)
}

class FilterViewController: UIViewController {

    weak var delegate: FilterViewControllerDelegate?

    private let mainView: UIView = {
        let mainView = UIView()
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 15
        mainView.backgroundColor = hexStringToUIColor(hex: "#E8E9EB")
        return mainView
    }()

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Ед. изм. расстояний"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private let segmentControl: UISegmentedControl = {
        let items = ["км", "л. орб."]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        segment.tintColor = UIColor.black
        return segment
    }()

    private let subView: UIView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#8E8E93")
        return view
    }()

    private let hazardousLabel: UILabel = {
        let label = UILabel()
        label.text = "Показывать только опасные"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private let hazardSwitch = UISwitch()

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Фильтр"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Применить", style: .done, target: self, action: #selector(applyAction))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .white
    }

    @objc func applyAction(sender: UIBarButtonItem) {
        delegate?.applyFilter(newFilter: MeteorsFilter.init(type: segmentControl.selectedSegmentIndex == 0 ? .km : .moon, showDangerous: hazardSwitch.isOn))
    }

    override func loadView() {
        super.loadView()

        view.addSubview(mainView)
        mainView.addSubview(mainLabel)
        mainView.addSubview(segmentControl)
        mainView.addSubview(subView)
        mainView.addSubview(hazardousLabel)
        mainView.addSubview(hazardSwitch)

        mainView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(88)
        }

        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(segmentControl.snp.leading).offset(8)
        }

        segmentControl.snp.makeConstraints {
            $0.centerY.equalTo(mainLabel)
            $0.trailing.equalToSuperview().offset(-4)
            $0.width.equalTo(113)
            $0.height.equalTo(29)
        }

        subView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10.5)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        hazardousLabel.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(10.5)
            $0.leading.equalTo(mainLabel.snp.leading)
            $0.trailing.equalTo(hazardSwitch.snp.leading)
        }

        hazardSwitch.snp.makeConstraints {
            $0.centerY.equalTo(hazardousLabel)
            $0.trailing.equalToSuperview().offset(-17)
        }

    }
}
