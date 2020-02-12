//
//  DescriptionViewModel.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation
import UIKit

protocol DescriptionViewModelProtocol {

	var film: Film { get set }
	func makeCellViewModel() -> FilmInformationCellViewModel

}

class DescriptionViewModel: DescriptionViewModelProtocol {

	// MARK: - Public properties

	var film: Film

	private var mainWireframe: MainWireframeProtocol
	private var contentManager: ContentManagerProtocol

	// MARK: - Lifecycle

	init(mainWireframe: MainWireframeProtocol, film: Film, contentManager: ContentManagerProtocol) {
		self.mainWireframe = mainWireframe
		self.film = film
		self.contentManager = contentManager
	}
	
	// MARK: - Public methods

	func makeCellViewModel() -> FilmInformationCellViewModel {
		return FilmInformationCellViewModel(film: film, contentManager: contentManager)
	}

}
