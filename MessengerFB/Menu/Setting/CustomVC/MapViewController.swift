//
//  MapViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 26/09/2025.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private var searchController: UISearchController!
    
    private var selectedTransport: MKDirectionsTransportType = .automobile
    private var currentDestination: MKMapItem?   // lưu điểm đến để đổi loại phương tiện
    
    private lazy var transportControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["🚗", "🏍", "🚶", "🚌"])
        control.selectedSegmentIndex = 0
        
        // Style segment
        control.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.4)
        control.selectedSegmentTintColor = .systemBlue
        control.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        control.layer.cornerRadius = 12
        control.layer.masksToBounds = true
        
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var blurContainer: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blurEffect)
        
        // Bo góc + shadow
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 6
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bản đồ"
        
        // Map
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        // Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Search
        let resultsVC = SearchResultsTableViewController()
        resultsVC.delegate = self
        searchController = UISearchController(searchResultsController: resultsVC)
        searchController.searchResultsUpdater = resultsVC
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Transport control
        view.addSubview(blurContainer)
        blurContainer.contentView.addSubview(transportControl)
        
        // Layout blurContainer
        NSLayoutConstraint.activate([
            blurContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            blurContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurContainer.widthAnchor.constraint(equalToConstant: 280),
            blurContainer.heightAnchor.constraint(equalToConstant: 50),
            
            transportControl.leadingAnchor.constraint(equalTo: blurContainer.contentView.leadingAnchor),
            transportControl.trailingAnchor.constraint(equalTo: blurContainer.contentView.trailingAnchor),
            transportControl.topAnchor.constraint(equalTo: blurContainer.contentView.topAnchor),
            transportControl.bottomAnchor.constraint(equalTo: blurContainer.contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Location delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        let coord = userLocation.coordinate
        let region = MKCoordinateRegion(center: coord,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                               longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Lỗi lấy vị trí: \(error.localizedDescription)")
    }
    
    // MARK: - Transport change
    @objc private func transportChanged() {
        switch transportControl.selectedSegmentIndex {
        case 0: selectedTransport = .automobile   // 🚗 ô tô
        case 1: selectedTransport = .automobile   // 🏍 xe máy (tạm dùng automobile)
        case 2: selectedTransport = .walking      // 🚶 đi bộ
        case 3: selectedTransport = .transit      // 🚌 công cộng
        default: selectedTransport = .automobile
        }
        
        if let dest = currentDestination {
            mapView.removeOverlays(mapView.overlays)
            showRoute(to: dest)
        }
    }
    
    // MARK: - Route hiển thị
    func showRoute(to destination: MKMapItem) {
        guard let currentLocation = locationManager.location else {
            print("Chưa lấy được vị trí hiện tại")
            return
        }
        
        currentDestination = destination // lưu lại
        
        let sourcePlacemark = MKPlacemark(coordinate: currentLocation.coordinate)
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destination
        request.transportType = selectedTransport
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            if let route = response?.routes.first {
                self?.mapView.addOverlay(route.polyline)
                self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                                edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 100, right: 50),
                                                animated: true)
            }
        }
    }
    
    // MARK: - Map overlay renderer
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            switch selectedTransport {
            case .automobile: renderer.strokeColor = .systemBlue
            case .walking: renderer.strokeColor = .systemGreen
            case .transit: renderer.strokeColor = .systemOrange
            default: renderer.strokeColor = .systemBlue
            }
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

// MARK: - Delegate nhận điểm search
extension MapViewController: SearchResultsDelegate {
    func didSelectMapItem(_ item: MKMapItem) {
        // Xóa cũ
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        // Thêm pin đích
        let annotation = MKPointAnnotation()
        annotation.title = item.name
        annotation.subtitle = item.placemark.title
        annotation.coordinate = item.placemark.coordinate
        mapView.addAnnotation(annotation)
        
        // Hiển thị route
        showRoute(to: item)
    }
}

