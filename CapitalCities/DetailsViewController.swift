//
//  DetailsViewController.swift
//  CapitalCities
//
//  Created by Igor Chernyshov on 18.07.2021.
//

import UIKit
import WebKit

final class DetailsViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet var webView: WKWebView!

	// MARK: - Properties
	var countryName: String = ""
	private var baseURL: URL = URL(string: "https://en.wikipedia.org/wiki")!

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		let countryURL = baseURL.appendingPathComponent(countryName)
		let pageRequest = URLRequest(url: countryURL)
		webView.load(pageRequest)
    }
}
