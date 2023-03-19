//
//  CitiesListViewController.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import UIKit

final class CitiesListViewController: UIViewController {
        
    private let searchController = UISearchController()
    private var viewModel: CitiesListViewModelPresentation!

    // MARK: Life Cycle

    static func create(with viewModel: CitiesListViewModelPresentation) -> CitiesListViewController {
        let view = CitiesListViewController.fromStoryboard(.city)
        view.viewModel = viewModel
        return view
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
    }
}

// MARK: - UITableViewDataSource

extension CitiesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let city = cities[indexPath.row]
//        cell.textLabel?.text = "\(city.name), \(city.countryCode)"
//        cell.detailTextLabel?.text = "Lat: \(city.latitude), Long: \(city.longitude)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CitiesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

private extension CitiesListViewController {
    func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

extension CitiesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
