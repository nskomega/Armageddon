//
//  MainViewController.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    private var viewModel: MainViewModelProtocol?

    // MARK: - Subviews
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(action))
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Армагеддон 2022"
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Methods
    @objc func action(sender: UIBarButtonItem) {
        let filterVC: FilterViewController =  ModuleBuilder.filterVC()
        filterVC.delegate = self
        navigationController?.pushViewController(filterVC, animated: true)
    }

    func setup(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel

        viewModel.getMeteor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")

        loadView()
    }

    override func loadView() {
        super.loadView()

        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-60)
        }
    }

    @objc func dellMeteor(_ sender: UIButton){
      let alert = UIAlertController(title: "Уничтожен", message: "Метеорит уничтожен", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)

      self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredMeteors.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        if let call = viewModel?.filteredMeteors[indexPath.row] {
            cell.delButton.tag = indexPath.row
            cell.delButton.addTarget(self, action: #selector(dellMeteor(_:)), for: .touchUpInside)
            cell.configure(model: call, filter: viewModel?.filter ?? MeteorsFilter())
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(at: indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel?.haveMorePages ?? false {
            if indexPath.row == (viewModel?.filteredMeteors.count ?? 0) {
                viewModel?.getMeteor()
            }
        }
    }
}

extension MainViewController: MainViewModelHandlerProtocol {
    func didLoadMeteor(count: Int) {
        guard let viewModel = viewModel else {return}
        DispatchQueue.main.async { [weak self] in
            if viewModel.filteredMeteors.count == count {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            } else {
                let startIndex: Int = viewModel.filteredMeteors.count - count - 1
                var indexes: [IndexPath] = []
                for ind in startIndex...(startIndex + count) {
                    indexes.append(IndexPath.init(row: ind, section: 0))
                }
                self?.tableView.insertRows(at: indexes, with: .automatic)
            }
        }
    }

    func failedLoading(error: Networking.CommonError) {
        let dialogMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }

    func meteorsUpdated() {
        tableView.reloadData()
    }
}

extension MainViewController: FilterViewControllerDelegate {
    func applyFilter(newFilter: MeteorsFilter) {
        viewModel?.applyFilter(newFilter: newFilter)
    }
}
