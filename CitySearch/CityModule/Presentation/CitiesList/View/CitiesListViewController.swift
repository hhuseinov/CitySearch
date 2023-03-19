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
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Life Cycle

    static func create(with viewModel: CitiesListViewModelPresentation) -> CitiesListViewController {
        let view = CitiesListViewController.fromStoryboard(.city)
        view.viewModel = viewModel
        view.viewModel.presentationDelegate = view
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
        setupSearchController()
        viewModel.viewDidLoad()
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: - UITableViewDataSource

extension CitiesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = viewModel.displayCities[indexPath.row + viewModel.displayCities.startIndex]
        cell.textLabel?.text = "\(city.name), \(city.country)"
        cell.detailTextLabel?.text = "Lat: \(city.coordinates.latitude), Long: \(city.coordinates.longitude)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CitiesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension CitiesListViewController {
    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

// MARK: - UISearchResultsUpdating

extension CitiesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.didSearch(query: searchText)
         } else {
            viewModel.didCancelSearch()
         }
    }
}

// MARK: - CitiesListViewModelPresentationDelegate

extension CitiesListViewController: CitiesListViewModelPresentationDelegate {
    func citiesUpdated() {
        tableView.reloadData()
    }
}
