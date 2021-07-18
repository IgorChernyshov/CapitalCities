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

	// MARK: - Properties
	private var isMapInSatelliteMode: Bool {
		self.mapView.mapType == .satellite
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigationBar()
		mapView.addAnnotations(makeAnnotations())
	}

	// MARK: - UI Configuration
	private func configureNavigationBar() {
		title = "Capitals"
		let mapTypeButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(didTapMapButton))
		navigationItem.rightBarButtonItem = mapTypeButton
		updateMapTypeButtonIcon()
	}

	private func updateMapTypeButtonIcon() {
		navigationItem.rightBarButtonItem?.image = isMapInSatelliteMode ? UIImage(systemName: "map") : UIImage(systemName: "network")
	}

	// MARK: - Selectors
	@objc private func didTapMapButton() {
		mapView.mapType = isMapInSatelliteMode ? .standard : .satellite
		updateMapTypeButtonIcon()
	}

	// MARK: - Data Source
	private func makeAnnotations() -> [MKAnnotation] {
		[
			Capital(title: "London", subtitle: "Home to the 2012 Summer Olympics.", coordinate: .init(latitude: 51.507222, longitude: -0.1275)),
			Capital(title: "Oslo", subtitle: "Founded over a thousand years ago.", coordinate: .init(latitude: 59.95, longitude: 10.75)),
			Capital(title: "Paris", subtitle: "Often called the City of Light.", coordinate: .init(latitude: 48.8567, longitude: 2.3508)),
			Capital(title: "Rome", subtitle: "Has a whole country inside it.", coordinate: .init(latitude: 41.9, longitude: 12.5)),
			Capital(title: "Washington DC", subtitle: "Named after George himself.", coordinate: .init(latitude: 38.895111, longitude: -77.036667))
		]
	}
}

// MARK: - MPMapViewDelegate
extension ViewController: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard annotation is Capital else { return nil }

		let identifier = "Capital"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
		if annotationView == nil {
			// Create a new annotation view
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView?.pinTintColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
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
		guard let capital = view.annotation as? Capital,
			  let viewController = storyboard?.instantiateViewController(identifier: "Details") as? DetailsViewController,
			  let capitalTitle = capital.title else { return }
		viewController.countryName = capitalTitle
		navigationController?.pushViewController(viewController, animated: UIView.areAnimationsEnabled)
	}
}
