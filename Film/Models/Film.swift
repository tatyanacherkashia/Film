//
//  Film.swift
//  Film
//
//  Created by Tatyana on 11/02/2020.
//  Copyright © 2020 Tatyana All rights reserved.
//

import Foundation
import ObjectMapper

enum RateLevel {

	case high
	case middle
	case low

}

class Film: Mappable {

	var id: Int = -1
	var originName: String = ""
	var russianName: String = ""
	var yearOfIssue: Int = 0
	var rate: Double?
	var description: String?
	var imageURL: String?
	var rateLevel: RateLevel? {
		guard let rating = rate else {
			return nil
		}
		if rating >= 7.0 {
			return .high
		} else {
			return rating > 5.0 ? .middle : .low
		}
	}
	
	required init?(map: Map) {

	}
	
	func mapping(map: Map) {
		id <- map["id"]
		originName <- map["name"]
		russianName <- map["localized_name"]
		yearOfIssue <- map["year"]
		rate <- map["rating"]
		imageURL <- map["image_url"]
		description <- map["description"]
	}

}
