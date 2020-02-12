//
//  ContentManager.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation
import ObjectMapper

typealias JSON = [String : Any?]

protocol ContentManagerProtocol {

	func fetchContent(completion: @escaping ([Film]?, Error?) -> ())
	func takeImage(url: URL, completion: @escaping (URL?, Error?) -> ())

}

class ContentManager: ContentManagerProtocol {

	// MARK: - Private properties

	private var internetService: InternetServiceProtocol
	private var fileManager: FileManager
	private var url = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json")
	private var films: [Film] = []

	// MARK: - Lifecycle

	init(internetService: InternetServiceProtocol, fileManager: FileManager) {
		self.internetService = internetService
		self.fileManager = fileManager
	}

	// MARK: - Public methods

	func fetchContent(completion: @escaping ([Film]?, Error?) -> ()) {
		guard let urlJson = url else {
			completion(nil, nil)
			return
		}
		internetService.makeRequest(url: urlJson, completion: { json in
			self.parseJSON(jsonData: json, completion: { error in
				completion(self.films, error)
			})
		})
	}
	
	func takeImage(url: URL, completion: @escaping (URL?, Error?) -> ()) {
		guard let directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
			return
		}
		let cacheUrl = directory.appendingPathComponent(url.lastPathComponent)
		if fileManager.fileExists(atPath: cacheUrl.path) {
			completion(cacheUrl, nil)
		} else {
			internetService.downloadFile(url: url, completion: { url, error in
				completion(url, error)
			})
		}
	}
	
	// MARK: - Private methods

	private func parseJSON(jsonData: Data?, completion: (Error?) -> ()) {
		guard let json = jsonData else {
			completion(nil)
			return
		}
		films = []
		do {
			let jsonResult = try JSONSerialization.jsonObject(with: json, options: .mutableLeaves)
			if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let films = jsonResult["films"] as? [JSON] {
				for film in films {
					if let film = Film(JSON: film as JSON) {
						self.films.append(film)
					}
				}
				completion(nil)
			}
		} catch {
			completion(error)
		}
	}

}
