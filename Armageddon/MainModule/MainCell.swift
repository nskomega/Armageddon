//
//  MainCell.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import UIKit
import SnapKit

class MainCell: UITableViewCell {

    var wightConstraint: Constraint?
    var heightConstraint: Constraint?

    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 7.0
        view.layer.masksToBounds =  false
        return view
    }()

    private let mainView: UIView = {
        let mainView = UIView()
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 15
        mainView.backgroundColor = .white
        return mainView
    }()

    private let subImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo")
        return imageview
    }()

    private let asteroidImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "asteroid")
        return imageview
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private let dinoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dino")
        return image
    }()

    private let diametrLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let flyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    @objc var dellAction: () -> () = {}

    var delButton: UIButton = {
        let button = UIButton()
        button.setTitle("УНИЧТОЖИТЬ", for: .normal)
        button.backgroundColor = hexStringToUIColor(hex: "#007AFF")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 14
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        loadView()
        delButton.addTarget(self, action: #selector(getter: dellAction), for: .touchUpInside)
    }

    func configure(model: NearEarthObject, filter: MeteorsFilter) {
        titleLabel.text = model.name
        diametrLabel.text = "Диаметр: \(Int(model.estimatedDiameter.meters.estimatedDiameterMax)) м"

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: "\(model.closeApproachData.last?.closeApproachDate ?? "")")
        inputFormatter.dateFormat = "dd MMMM YYYY"
        let resultString = inputFormatter.string(from: showDate ?? Date())
        flyLabel.text = "Подлетает: \(resultString)"

        var distance = ""
        if filter.type == .km {
            distance = model.closeApproachData.first?.missDistance.kilometers ?? ""
        } else {
            distance = model.closeApproachData.first?.missDistance.lunar ?? ""
        }
        let distanceDouble = Double(distance) ?? 0.0
        let distanceInt = Int(distanceDouble)
        let intFormatted = distanceInt.formattedWithSeparator
        distanceLabel.text = "на растояние \(intFormatted) \(filter.type == .km ? "км" : "л.орб.")"

        let hazardous = model.isPotentiallyHazardousAsteroid
        if hazardous == true {
            subImageView.image = UIImage(named: "logo1")
            let mainString = "Оценка: Опасен"
            let stringToColor = "Опасен"
            let range = (mainString as NSString).range(of: stringToColor)
            let attributedString = NSMutableAttributedString(string: mainString)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
            gradeLabel.attributedText = attributedString
        } else {
            gradeLabel.text = "Оценка: не опасен"
            subImageView.image = UIImage(named: "logo")
        }

        let diamer = Int(model.estimatedDiameter.meters.estimatedDiameterMax)
        if diamer > 85 && diamer < 300 {
            asteroidImageView.snp.remakeConstraints {
                $0.top.equalTo(22)
                $0.leading.equalTo(27)
                $0.width.equalTo(108)
                $0.height.equalTo(109)
            }
            self.wightConstraint?.update(inset: 108)
            self.heightConstraint?.update(inset: 109)
        } else {
            asteroidImageView.snp.remakeConstraints {
                $0.top.equalTo(22)
                $0.leading.equalTo(27)
                $0.width.equalTo(338)
                $0.height.equalTo(341)
            }
            self.wightConstraint?.update(inset: 338)
            self.heightConstraint?.update(inset: 341)
        }
    }

    func loadView() {
        self.addSubview(shadowView)
        shadowView.addSubview(mainView)
        mainView.addSubview(subImageView)
        mainView.addSubview(asteroidImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(dinoImageView)
        mainView.addSubview(diametrLabel)
        mainView.addSubview(flyLabel)
        mainView.addSubview(distanceLabel)
        mainView.addSubview(gradeLabel)
        mainView.addSubview(delButton)

        shadowView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(290)
        }
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        subImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(mainView)
            $0.height.equalTo(145)
        }
        asteroidImageView.snp.makeConstraints {
            $0.top.equalTo(22)
            $0.leading.equalTo(27)
            self.wightConstraint = $0.width.equalTo(61).constraint
            self.heightConstraint = $0.height.equalTo(62).constraint
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(105)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(dinoImageView.snp.leading)
        }
        dinoImageView.snp.makeConstraints {
            $0.bottom.equalTo(subImageView.snp.bottom)
            $0.trailing.equalTo(subImageView.snp.trailing).offset(-12)
            $0.width.equalTo(35)
            $0.height.equalTo(30)
        }
        diametrLabel.snp.makeConstraints {
            $0.top.equalTo(subImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        flyLabel.snp.makeConstraints {
            $0.top.equalTo(diametrLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(diametrLabel)
        }
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(flyLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(flyLabel)
        }
        gradeLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.bottom).offset(16)
            $0.leading.equalTo(distanceLabel.snp.leading)
            $0.trailing.equalTo(delButton.snp.leading).offset(8)
        }
        delButton.snp.makeConstraints {
            $0.centerY.equalTo(gradeLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(121)
            $0.height.equalTo(28)
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
