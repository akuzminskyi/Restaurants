//
//  String+Localizable.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 18/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension String {
    public func localized(inBundle bundle: Bundle = .main) -> String {
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
