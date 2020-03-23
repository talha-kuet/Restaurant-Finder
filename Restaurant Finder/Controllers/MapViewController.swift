//
//  ViewController.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/19/20.
//

import UIKit
import GoogleMaps

class MapViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet private weak var mapView: GMSMapView!
    
    
    //MARK:- Properties
    private var locationManager: CLLocationManager!
    private var defalutLocationCoordinate = CLLocationCoordinate2D(latitude: 23.7815271, longitude: 90.3982979)
    private var searchController: UISearchController!
    private var isNavBarHidden = false
    private var searchKeyword = ""
    private var venues = [Venue]()
    private var selectedVenue: Venue?
    private var markerPositions = [CLLocationCoordinate2D]()
    private var isLocationInitialized = false
    private var isKeywordSearched = false
    
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isSearching: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Find Restaurants"
        
        setupLocationManager()
        setupSearchBar()
    }
    
    
    //MARK:- Configure UI
    private func setupSearchBar() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.delegate = self
        
        searchController = UISearchController(searchResultsController: vc)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search Restaurants"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.definesPresentationContext = true
    }
    
    private func setupLocationManager() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()

            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.delegate = self
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK:- Fetch Data from API
    private func fetchVenues(lat: Double, lon: Double) {
        
        mapView.clear()
        markerPositions.removeAll()
        
        showLoadingBlocker()
        
        APIService.shared.searchVenuesWithCoordinate(latitude: lat, longitude: lon) { [weak self] (venues, error) in
            
            self?.hideLoadingBlocker()
            
            if let error = error {
                self?.showErrorAlert(error)
                print("ERROR FOUND: \(error)")
                return
            }
            
            guard let venues = venues else {return}
            
            self?.venues = venues
            
            DispatchQueue.main.async { [weak self] in
                self?.placeMarkers()
            }
        }
    }
    
    private func fetchVenueWith(keyword: String) {
        
        showLoadingBlocker()
        
        APIService.shared.searchVenuesWithCoordinate(latitude: defalutLocationCoordinate.latitude, longitude: defalutLocationCoordinate.longitude, query: keyword) { [weak self] (venues, error) in
            
            self?.hideLoadingBlocker()

            if let error = error {
                self?.showErrorAlert(error)
                return
            }

            guard let venues = venues else {return}
            
            DispatchQueue.main.async { [weak self] in
                self?.placeCustomMarker(keyword: keyword, venues: venues)
            }
        }
    }
    
    @objc private func fetchPlace() {
        
//        mapView.clear()
//        markerPositions.removeAll()
        
        searchController.searchBar.isLoading = true
        
        APIService.shared.searchVenuesWithCoordinate(latitude: defalutLocationCoordinate.latitude, longitude: defalutLocationCoordinate.longitude, query: searchKeyword) { [weak self] (venues, error) in
            
            self?.searchController.searchBar.isLoading = false
            
            if let error = error {
                self?.showErrorAlert(error)
                return
            }
            
            DispatchQueue.main.async {
                if let vc = self?.searchController.searchResultsController as? ResultViewController, let venues = venues {
                    vc.venues = venues
                    vc.resultTableView.reloadData()
                }
            }
        }
    }
    
    //MARK:- Helper Methods
    private func isMarkerAlreadyPalced(lat: Double, lon: Double) -> Bool {
        for position in markerPositions {
            if position == CLLocationCoordinate2D(latitude: lat, longitude: lon) {
                return true
            }
        }
        return false
    }
    
    private func placeMarkers() {
        
        mapView.clear()
        markerPositions.removeAll()
        
        venues.forEach { venue in
            let position = CLLocationCoordinate2D(latitude: venue.location.latitude, longitude: venue.location.longitude)
            let marker = PlaceMarker(venue: venue)
            marker.map = mapView
            
            markerPositions.append(position)
        }
    }
    
    private func placeCustomMarker(keyword: String, venues: [Venue]) {
        
        mapView.clear()
        markerPositions.removeAll()
        
        for venue in venues {
            
            let lat = venue.location.latitude
            let lon = venue.location.longitude
            
            if venue.name == keyword {
                mapView.animate(to: GMSCameraPosition(latitude: venue.location.latitude, longitude: venue.location.longitude, zoom: 15))
                
                if isMarkerAlreadyPalced(lat: lat, lon: lon) == false {
                    let marker = PlaceMarker(venue: venue)
                    marker.map = mapView
                }
                break
            }
        }
    }
}

extension MapViewController: UISearchControllerDelegate {
    
}

//MARK:- UISearchResultsUpdating
extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let keyword = searchController.searchBar.text else {return}
        
        if keyword.count > 0 && isSearching && keyword != searchKeyword {

            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchPlace), object: nil)

            searchKeyword = keyword
            self.perform(#selector(fetchPlace), with: nil, afterDelay: 0.5)
        }
        else {
            searchKeyword = ""
            if isKeywordSearched {
                isKeywordSearched = false
                placeMarkers()
            }
        }
    }
}

//MARK:- ResultViewControllerDelegate
extension MapViewController: ResultViewControllerDelegate {
    
    func resultViewController(_ vc: UIViewController, selected venue: Venue) {
        selectedVenue = venue
        searchController.isActive = false
        searchController.searchBar.text = venue.name
        
        isKeywordSearched = true
        
        fetchVenueWith(keyword: venue.name)
    }
}

//MARK:- CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {return}
        
        locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {return}
        
        defalutLocationCoordinate = location.coordinate
        mapView.camera = GMSCameraPosition(target: defalutLocationCoordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        if isLocationInitialized == false {
            fetchVenues(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            isLocationInitialized = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LOCATION MANAGER ERROR: \(error.localizedDescription)")
    }
}

//MARK:- GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        
        guard let placeMarker = marker as? PlaceMarker else {return nil}
        guard let infoView = UIView.viewFromNibName(MarkerInfoView.nibName) as? MarkerInfoView else {return nil}
        
        infoView.nameLabel.text = placeMarker.venue.name
        infoView.addressLabel.text = placeMarker.venue.location.address

      return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        self.isNavBarHidden = !self.isNavBarHidden
        self.navigationController?.setNavigationBarHidden(self.isNavBarHidden, animated: true)
    }
}
