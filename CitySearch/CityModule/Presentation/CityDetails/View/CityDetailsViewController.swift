//
//  CityDetailsViewController.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import MapKit
import UIKit

final class CityDetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private var viewModel: CityDetailsViewModelPresentation!

    // MARK: Life Cycle

    static func create(with viewModel: CityDetailsViewModelPresentation) -> CityDetailsViewController {
        let view = CityDetailsViewController.fromStoryboard(.city)
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.city.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPointForLocation()
    }

    func setupPointForLocation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = viewModel.city.coordinates
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(
            center: viewModel.city.coordinates,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        mapView.setRegion(region, animated: true)
    }
}
