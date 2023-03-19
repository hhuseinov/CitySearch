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

        setupPointForLocation()
    }
    
    func setupPointForLocation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = viewModel.coordinates
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(
            center: viewModel.coordinates,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
}
