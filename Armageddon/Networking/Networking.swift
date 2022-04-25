//
//  Networking.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import Foundation
import UIKit

class Networking {

    enum CommonError: Error {
        case noData
        case cantDecode
    }

    private let firstPage: String = "http://www.neowsapp.com/rest/v1/feed?start_date=2022-04-21&end_date=2022-04-28&detailed=false&api_key=PmLF0tYjHUJFs9TcBemVU14EsbMkvTMdWcrzt0tW"

    func getMeteor(page: String? = nil, completion: @escaping (Result<ArmageddonResponse, CommonError>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: page ?? firstPage)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 30.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tennis = try JSONDecoder().decode(ArmageddonResponse.self, from: data)
                completion(.success(tennis))
            } catch _ {
                completion(.failure(.cantDecode))
            }
        })
        dataTask.resume()
    }
}
