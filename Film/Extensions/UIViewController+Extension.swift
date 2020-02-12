//
//  UIViewController+Extension.swift
//  DVR Center
//
//  Created by Roman Manyakhin on 06/06/2019.
//  Copyright © 2019 Center of Navigation Technologies. All rights reserved.
//

import UIKit

struct Storyboard {
	let name: String

	static let launchViewController = Storyboard(name: "LaunchViewController")

}

extension UIViewController {

	static func nibInit() -> Self {
		let controller = self.init(nibName: className, bundle: nil)
		return controller
	}

	static func controllerFromStoryboard(_ storyboard: Storyboard, identifier: String? = nil) -> Self {
		let id: String
		if let identifier = identifier {
			id = identifier
		} else {
			id = className
		}
		return controllerInStoryboard(UIStoryboard(name: storyboard.name, bundle: nil), identifier: id)
	}

	private static func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
		guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
			fatalError("Not T")
		}
		return vc
	}

	private static func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
		return instantiateControllerInStoryboard(storyboard, identifier: identifier)
	}

	private static func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
		return controllerInStoryboard(storyboard, identifier: className)
	}

}

extension NSObject {

	static var className: String {
		return String(describing: self)
	}

}
