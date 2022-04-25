//
//  Storage.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 23.04.2022.
//

import Foundation

class Storage {
    static var meteor: [NearEarthObject] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "meteor"),
                  let meteor = try? JSONDecoder().decode([NearEarthObject].self, from: data)
            else {
                return []
            }
            return meteor
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "meteor")
            }
        }
    }
}
