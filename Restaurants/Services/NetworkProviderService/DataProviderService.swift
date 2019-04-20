//
//  DataProviderService.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 18/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit.NSDataAsset

struct DataProviderService: DataProviderServiceInterface {
    enum Error: Swift.Error, LocalizedError {
        case notFound

        var errorDescription: String? {
            switch self {
            case .notFound:
                return "DataProviderService_Error_NotFound".localized()
            }
        }
    }

    func data(fromAsset name: String) throws -> Data {
        guard let dataAsset = NSDataAsset(name: name) else {
            throw Error.notFound
        }

        return dataAsset.data
    }
}
