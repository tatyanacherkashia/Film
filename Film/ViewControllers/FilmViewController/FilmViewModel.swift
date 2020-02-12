//
//  FilmViewModel.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation

protocol FilmViewModelProtocol {
	
	var delegate: FilmViewModelDelegate? { get set }
	var filmCollections: [FilmCollection] { get set }
	func makeFilmCellViewModel(indexPath: IndexPath) -> FilmTableCellViewModel?
	func fetchContent()
	func openDescriptionViewController(indexPath: IndexPath)
}

protocol FilmViewModelDelegate: class {

	func reloadContent()
	func errorFetch()

}

class FilmViewModel: FilmViewModelProtocol {

	// MARK: - Public properties

	var filmCollections: [FilmCollection] = [FilmCollection]()
	weak var delegate: FilmViewModelDelegate?

	// MARK: - Private properties

	private var mainWireframe: MainWireframeProtocol
	private var contentManager: ContentManagerProtocol

	// MARK: - Lifecycle

	init(mainWireframe: MainWireframeProtocol, contentManager: ContentManagerProtocol) {
		self.mainWireframe = mainWireframe
		self.contentManager = contentManager
	}

	// MARK: - Public methods

	func fetchContent() {
		contentManager.fetchContent { films, error in
			guard let films = films else {
				if error != nil {
					self.delegate?.errorFetch()
				}
				return
			}
			self.makeFilmCollection(films: films)
			self.delegate?.reloadContent()
		}
	}
	
	func makeFilmCellViewModel(indexPath: IndexPath) -> FilmTableCellViewModel? {
		let film = filmCollections[indexPath.section].films[indexPath.row]
		return FilmTableCellViewModel(film: film)
	}
	
	func openDescriptionViewController(indexPath: IndexPath) {
		let film = filmCollections[indexPath.section].films[indexPath.row]
		mainWireframe.openDescriptionViewController(film: film)
	}

	// MARK: - Private methods

	private func makeFilmCollection(films: [Film]) {
		filmCollections = []
		let sortedFilms = films.sorted(by: { $0.yearOfIssue < $1.yearOfIssue})
		sortedFilms.forEach { film in
			if !filmCollections.contains { $0.year == film.yearOfIssue } {
				filmCollections.append(FilmCollection(films: [], year: film.yearOfIssue))
			}
			filmCollections.last?.films.append(film)
		}

		for filmCollection in filmCollections {
			filmCollection.films.sort(by: {
				guard let rate0 = $0.rate, let rate1 = $1.rate else { return false }
				return rate0 > rate1
			})
		}
	}

}
