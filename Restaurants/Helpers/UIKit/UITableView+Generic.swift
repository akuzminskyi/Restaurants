//
//  UITableView+Generic.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath,
        withIdentifier identifier: String = String(describing: T.self)
        ) -> T {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
