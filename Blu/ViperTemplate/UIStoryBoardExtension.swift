//
//  UIStoryBoardExtension.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 25/12/24.
//

import Foundation
import UIKit

extension UIStoryboard {

    func instiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
    let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}
