//
//  MainViewModel.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import Foundation

struct MeteorsFilter {
    enum MeasureType {
case km, moon
    }
    var type: MeasureType = .km
    var showDangerous: Bool = true
}

protocol MainViewModelHandlerProtocol: AnyObject {
    func meteorsUpdated()
    func didLoadMeteor(count: Int)
    func failedLoading(error: Networking.CommonError)
}

protocol MainViewModelProtocol: AnyObject {
    var filteredMeteors: [NearEarthObject] { get set}
    var handler: MainViewModelHandlerProtocol? { get }
    func getMeteor()
    func didSelect(at: Int)
    var haveMorePages: Bool {get}
    var isLoading: Bool {get set}
    func applyFilter(newFilter: MeteorsFilter)
    var filter: MeteorsFilter {get set}
}

final class MainViewModel: MainViewModelProtocol {

    // MARK: Properties
    private let router: MainRouter
    private let networking: Networking
    internal var meteor: [NearEarthObject] = [] {
        didSet {
            Storage.meteor = meteor
        }
    }
    var filteredMeteors: [NearEarthObject] = []
    private(set) var handler: MainViewModelHandlerProtocol?
    private(set) var nextLinks: ArmageddonResponseLinks?

    var haveMorePages: Bool {
        if let nextLinks = nextLinks {
            return !nextLinks.next.isEmpty
        } else {
            return false
        }
    }

    var isLoading: Bool = false

    var filter: MeteorsFilter = MeteorsFilter()

    init(router: MainRouter, networking: Networking, handler: MainViewModelHandlerProtocol?) {
        self.router = router
        self.networking = networking
        self.handler = handler
    }

    func applyFilter(newFilter: MeteorsFilter) {
        filter = newFilter
        filteredMeteors = meteor.filter({ value in
            if self.filter.showDangerous {
                return value.isPotentiallyHazardousAsteroid
            } else {
                return true
            }
        })
        handler?.meteorsUpdated()
    }

    // MARK: Methods
    func getMeteor() {
        guard !isLoading else {return}
        isLoading = true
        networking.getMeteor(page: nextLinks?.next) { result in
            self.isLoading = false
            switch result {
            case .success(let response):
                let newMeteors = Array(response.nearEarthObjects.values.flatMap({$0}))
                self.meteor.append(contentsOf: newMeteors)

                let filtered = newMeteors.filter({ value in
                    if self.filter.showDangerous {
                        return true
                    } else {
                        return value.isPotentiallyHazardousAsteroid
                    }
                })
                self.filteredMeteors .append(contentsOf: filtered)
                self.nextLinks = response.links
                self.handler?.didLoadMeteor(count: filtered.count)
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handler?.failedLoading(error: error)
                }
                break
            }

        }
    }

    func didSelect(at index: Int) {
        router.showBottomViewController(meteor[index])
    }
}
