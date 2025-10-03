//
//  SearchResultsTableViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 29/09/2025.


import UIKit
import MapKit

protocol SearchResultsDelegate: AnyObject {
    func didSelectMapItem(_ item: MKMapItem)
}

class SearchResultsTableViewController: UITableViewController, UISearchResultsUpdating {
    private var completer = MKLocalSearchCompleter()
    private var results: [MKLocalSearchCompletion] = []
    weak var delegate: SearchResultsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completer.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            results = []
            tableView.reloadData()
            return
        }
        completer.queryFragment = text
    }
    
    // MARK: - Table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let completion = results[indexPath.row]
        cell.textLabel?.text = completion.title
        cell.detailTextLabel?.text = completion.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = results[indexPath.row]
        
        // Convert completion → MKMapItem
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            if let item = response?.mapItems.first {
                self?.delegate?.didSelectMapItem(item)
            }
        }
        dismiss(animated: true)
    }
}

extension SearchResultsTableViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Completer error: \(error.localizedDescription)")
    }
}
