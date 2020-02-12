//
//  DescriptionViewController.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation
import UIKit

class DescriptionViewController: UIViewController {

	// MARK: - Outlets

	@IBOutlet weak var tableView: UITableView!

	// MARK: - Public properties

	var viewModel: DescriptionViewModelProtocol?

	// MARK: - Lifecycle

	override func viewDidLoad() {
		setNavigationBar()
		setTableView()
	}
	
	// MARK: - Privat methods
	
	func setTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorInset = .zero
		tableView.estimatedRowHeight = 220
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(FilmInformationTableViewCell.nib(), forCellReuseIdentifier: FilmInformationTableViewCell.reuseId)
		tableView.register(DescriptionTableViewCell.nib(), forCellReuseIdentifier: DescriptionTableViewCell.reuseId)
		self.tableView.tableFooterView = UIView()
	}
	
	private func setNavigationBar() {
		self.navigationItem.title = viewModel?.film.russianName
		self.navigationItem.largeTitleDisplayMode = .never
		self.navigationController?.navigationItem.largeTitleDisplayMode = .never
	}

}

extension DescriptionViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

}

extension DescriptionViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel?.film.description != nil ? 2 : 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			guard let cell = self.tableView.dequeueReusableCell(withIdentifier: FilmInformationTableViewCell.reuseId, for: indexPath) as? FilmInformationTableViewCell else {
				fatalError("Not FilmInformationTableViewCell")
			}
			let viewModel = self.viewModel?.makeCellViewModel()
			cell.viewModel = viewModel
			cell.setCell()
			return cell
		} else {
			guard let cell = self.tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.reuseId, for: indexPath) as? DescriptionTableViewCell else {
				fatalError("Not DescriptionTableViewCell")
			}
			cell.setCell(text: viewModel?.film.description ?? "")
			return cell
		}
	}

}
