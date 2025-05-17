//
//  ReusableIdentifier.swift
//  ListUsers
//
//  Created by Igor Custodio on 28/02/23.
//

import UIKit

public protocol ReusableIdentifier: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableIdentifier where Self: UIView {
    public static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}
