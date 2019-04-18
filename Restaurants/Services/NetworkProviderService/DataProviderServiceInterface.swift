//
//  DataProviderServiceInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 18/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol DataProviderServiceInterface {
    func data(fromAsset name: String) throws -> Data
}
