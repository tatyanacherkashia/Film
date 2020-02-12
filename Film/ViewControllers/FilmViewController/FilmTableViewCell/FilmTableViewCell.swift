//
//  FilmTableViewCell.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation
import UIKit

class FilmTableViewCell: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet weak var filmName: UILabel!
	@IBOutlet weak var filmDescription: UILabel!
	@IBOutlet weak var rate: UILabel!

	// MARK: - Public properties

	static let reuseId = "FilmTableViewCell"
	var viewModel: FilmTableCellViewModelProtocol?
	
	// MARK: - Public methods

	func setCell() {
		filmName.text = viewModel?.film?.russianName
		filmDescription.text = viewModel?.film?.originName
		switch viewModel?.film?.rateLevel {
		case .high:
			rate.textColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
		case .middle:
			rate.textColor = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
		case .low:
			rate.textColor = #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
		case .none:
			break
		}
		if let rate = viewModel?.film?.rate {
			self.rate.text = String(rate)
		} else {
			rate.text = nil
		}
	}

}
