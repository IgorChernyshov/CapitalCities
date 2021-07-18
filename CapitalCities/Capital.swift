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
	private(set) var subtitle: String?
	private(set) var coordinate: CLLocationCoordinate2D

	// MARK: - Initializer
	init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.subtitle = subtitle
		self.coordinate = coordinate
	}
}
