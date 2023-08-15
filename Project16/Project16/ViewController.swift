//
//  ViewController.swift
//  Project16
//
//  Created by Tareq Alhammoodi on 15.08.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        presentMapTypeSheet()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            if let pin = annotationView as? MKPinAnnotationView {
                pin.pinTintColor = .link
            }
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        /*
         let placeName = capital.title
         let placeInfo = capital.info
         let alert = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         present(alert, animated: true)
         */
        let vc = WebView()
        vc.location = capital.title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentMapTypeSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        // hybrid
        let hybridAction = UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.hybrid
        }
        actionSheet.addAction(hybridAction)
        // hybrid flyover
        let hybridFlyoverAction = UIAlertAction(title: "Hybrid Flyover", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.hybridFlyover
        }
        actionSheet.addAction(hybridFlyoverAction)
        // muted standard
        let mutedStandardAction = UIAlertAction(title: "Muted Standard", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.mutedStandard
        }
        actionSheet.addAction(mutedStandardAction)
        // satellite
        let satelliteAction = UIAlertAction(title: "Satellite", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.satellite
        }
        actionSheet.addAction(satelliteAction)
        // satelliteFlyover
        let satelliteFlyoverAction = UIAlertAction(title: "Satellite Flyover", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.satelliteFlyover
        }
        actionSheet.addAction(satelliteFlyoverAction)
        // standard
        let standardAction = UIAlertAction(title: "Standard", style: .default) { [weak self] _ in
            self?.mapView.mapType = MKMapType.standard
        }
        actionSheet.addAction(standardAction)
        // cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }

}

