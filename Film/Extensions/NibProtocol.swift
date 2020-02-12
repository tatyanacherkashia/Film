//
//  NibProtocol.swift
//
//  Created by Roman Manyakhin on 09/10/2019.
//  Copyright © 2019 Voity. All rights reserved.
//

import UIKit

protocol NibProtocol {

	static func nib() -> UINib

}

extension NibProtocol where Self: NSObject {

	static func nib() -> UINib {
		return UINib(nibName: className, bundle: nil)
	}

}

extension UITableViewCell: NibProtocol {}

extension UICollectionViewCell: NibProtocol {}
