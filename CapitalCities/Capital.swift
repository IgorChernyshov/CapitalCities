//
//  Capital.swift
//  CapitalCities
//
//  Created by Igor Chernyshov on 18.07.2021.
//

import UIKit
import MapKit

final class Capital: NSObject, MKAnnotation {

	// MARK: - Properties
	private(set) var title: String?
	private(set) var info: String
	private(set) var coordinate: CLLocationCoordinate2D

	// MARK: - Initializer
	init(title: String, info: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.info = info
		self.coordinate = coordinate
	}
}
