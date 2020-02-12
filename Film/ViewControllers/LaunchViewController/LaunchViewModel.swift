//
//  LaunchViewModel.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation
import CoreLocation

protocol LaunchViewModelProtocol {

	func needOpenHome()

}

class LaunchViewModel: LaunchViewModelProtocol {

	// MARK: - Public properties

	// MARK: - Private properties

	private var mainWireframe: MainWireframeProtocol

	// MARK: - Lifecycle

	init(mainWireframe: MainWireframeProtocol) {
		self.mainWireframe = mainWireframe
	}

	// MARK: - Public methods

	func needOpenHome() {
		mainWireframe.openHome()
	}

}
