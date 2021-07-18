//
//  ViewController.swift
//  CapitalCities
//
//  Created by Igor Chernyshov on 17.07.2021.
//

import UIKit
import MapKit

final class ViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet var mapView: MKMapView!

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.addAnnotations(makeAnnotations())
	}

	// MARK: - Data Source
	private func makeAnnotations() -> [MKAnnotation] {
		[
			Capital(title: "London", info: "Home to the 2012 Summer Olympics.", coordinate: .init(latitude: 51.507222, longitude: -0.1275)),
			Capital(title: "Oslo", info: "Founded over a thousand years ago.", coordinate: .init(latitude: 59.95, longitude: 10.75)),
			Capital(title: "Paris", info: "Often called the City of Light.", coordinate: .init(latitude: 48.8567, longitude: 2.3508)),
			Capital(title: "Rome", info: "Has a whole country inside it.", coordinate: .init(latitude: 41.9, longitude: 12.5)),
			Capital(title: "Washington DC", info: "Named after George himself.", coordinate: .init(latitude: 38.895111, longitude: -77.036667))
		]
	}
}

// MARK: - MPMapViewDelegate
extension ViewController: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard annotation is Capital else { return nil }

		let identifier = "Capital"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
		if annotationView == nil {
			// Create a new annotation view
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView?.canShowCallout = true
			let button = UIButton(type: .detailDisclosure)
			annotationView?.rightCalloutAccessoryView = button
		} else {
			// Use a dequeued annotation view
			annotationView?.annotation = annotation
		}

		return annotationView
	}

	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let capital = view.annotation as? Capital else { return }
		let placeName = capital.title
		let placeInfo = capital.info

		let alertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default))
		present(alertController, animated: UIView.areAnimationsEnabled)
	}
}
