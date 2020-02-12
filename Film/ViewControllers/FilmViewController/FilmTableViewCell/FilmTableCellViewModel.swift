//
//  FilmTableCellViewModel.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation

protocol FilmTableCellViewModelProtocol {

	var film: Film? { get set }

}

class FilmTableCellViewModel: FilmTableCellViewModelProtocol {

	// MARK: - Public properties

	var film: Film?

	// MARK: - Lifecycle

	init(film: Film) {
		self.film = film
	}

}
