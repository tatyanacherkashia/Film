//
//  LaunchViewController.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

	// MARK: - Public properties

	var viewModel: LaunchViewModelProtocol?
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel?.needOpenHome()
	}

}
