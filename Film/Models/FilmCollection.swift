//
//  FilmCollection.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation

class FilmCollection {
	
	var films: [Film]
	var year: Int

	init(films: [Film], year: Int) {
		self.films = films
		self.year = year
	}

}
