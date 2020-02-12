//
//  ViewController.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import UIKit

class FilmViewController: UIViewController {

	// MARK: - Outlets

	@IBOutlet weak var tableView: UITableView!

	// MARK: - Public properties

	var filmViewModel: FilmViewModelProtocol?
	
	// MARK: - Private properties
	
	private var refreshControl: UIRefreshControl?

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		setTableView()
		filmViewModel?.delegate = self
		filmViewModel?.fetchContent()
		refreshControl = UIRefreshControl()
		tableView.refreshControl = refreshControl
		refreshControl?.addTarget(self, action: #selector(refreshMedia(_:)), for: .valueChanged)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setNavigationBar()
	}

	// MARK: - Private methods
	
	private func setNavigationBar() {
		self.navigationItem.title = "Фильмы"
		self.navigationController?.navigationBar.isTranslucent = false
		self.extendedLayoutIncludesOpaqueBars = true
		self.tableView.contentInsetAdjustmentBehavior = .scrollableAxes
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
	private func setTableView() {
		tableView.rowHeight = 80
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(FilmTableViewCell.nib(), forCellReuseIdentifier: FilmTableViewCell.reuseId)
	}
	
	private func errorFetchContent() {
		let alert = UIAlertController(title: nil, message: NSLocalizedString("Отсутствует подключение к сети", comment: ""), preferredStyle: .alert)
		alert.view.tintColor = #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1)
		let actionOff = UIAlertAction(title: NSLocalizedString("Ок", comment: ""), style: .cancel)
		alert.addAction(actionOff)
		present(alert, animated: true, completion: nil)
	}

	// MARK: - Outlet actions

	@objc private func refreshMedia(_ sender: UIRefreshControl) {
		filmViewModel?.fetchContent()
	}

}

extension FilmViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		filmViewModel?.openDescriptionViewController(indexPath: indexPath)
	}

	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let title = UILabel()
		title.frame = CGRect(x: 16, y: 16, width: view.frame.width, height: 22)
		if let font = UIFont(name: "Roboto", size: 13) {
			title.font = font
		}
		title.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
		if let year = filmViewModel?.filmCollections[section].year {
			title.text = String(year)
		}
		let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 38))
		header.addSubview(title)
		if #available(iOS 13.0, *) {
			header.backgroundColor = .secondarySystemBackground
		} else {
			header.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
		}
		return header
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 38
	}

}

extension FilmViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return filmViewModel?.filmCollections.count ?? 0
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filmViewModel?.filmCollections[section].films.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.reuseId, for: indexPath) as? FilmTableViewCell else {
			fatalError("Not MediaTableViewCell")
		}
		let cellModel = filmViewModel?.makeFilmCellViewModel(indexPath: indexPath)
		cell.viewModel = cellModel
		cell.setCell()
		return cell
	}

}

extension FilmViewController: FilmViewModelDelegate {

	func errorFetch() {
		errorFetchContent()
	}

	func reloadContent() {
		refreshControl?.endRefreshing()
		tableView.reloadData()
	}

}


