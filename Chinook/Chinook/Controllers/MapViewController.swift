//
//  MapViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-29.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    var manager:CLLocationManager!
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var latitude:CLLocationDegrees = 42.8452792
        var longditude:CLLocationDegrees = -79.4895854
        
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var churchLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longditude)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(churchLocation, theSpan)
        
        mapView.setRegion(theRegion, animated: true)
        
        var homeLocation = MKPointAnnotation()
        
        homeLocation.coordinate = churchLocation
        
        homeLocation.title = "Jeff's Home"
        
        homeLocation.subtitle = "My First House"
        
        mapView.addAnnotation(homeLocation)

        var lpgr = UILongPressGestureRecognizer(target: self, action: "longPressHandler:")
        
        lpgr.minimumPressDuration = 2.0;
        
        mapView.addGestureRecognizer(lpgr)
        
        
        
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        println("locationManager :: didUpdateLocations = \(locations)")
        var userLocation:CLLocation = locations[0] as CLLocation
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longditude:CLLocationDegrees = userLocation.coordinate.longitude
        
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longditude)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, theSpan)
        
        mapView.setRegion(theRegion, animated: true)
        var movingLocation = MKPointAnnotation()
        
        movingLocation.coordinate = currentLocation
        
        movingLocation.title = "We are heading to Vancouver"
        
        movingLocation.subtitle = "My X5"
        
        mapView.addAnnotation(movingLocation)


    }
    
    func locationManager(manager:CLLocationManager, didFailWithError error:NSError)
    {
        println(error)
        println("locationManager :: didFailWithError")
    }
    
    func longPressHandler(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint:CGPoint = gestureRecognizer.locationInView(self.mapView)
        
        var touchMapCoordinate:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
        
        var newannotation = MKPointAnnotation()
        
        newannotation.coordinate = touchMapCoordinate
        
        newannotation.title = "test"
        
        newannotation.subtitle = "another test"
        
        mapView.addAnnotation(newannotation)
        
        println(touchMapCoordinate.latitude)
        println(touchMapCoordinate.longitude)
        
        var ceo:CLGeocoder = CLGeocoder()
        
        
        
        var arr = []
        
        var err = []
        
        var targetLocation:CLLocation = CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
        
        ceo.reverseGeocodeLocation(targetLocation, completionHandler:
            {(placemarks, error) in
                if (error != nil) {println("reverse geodcode fail: \(error.localizedDescription)")}
                let pm = placemarks
                let p = CLPlacemark(placemark: pm?[0] as CLPlacemark)
                println(p.subThoroughfare)
                println(p.thoroughfare)
        })
        
        /*
        self.placemark.subThoroughfare ? self.placemark.subThoroughfare : "" ,
        self.placemark.thoroughfare ? self.placemark.thoroughfare : "",
        self.placemark.locality ? self.placemark.locality : "",
        self.placemark.postalCode ? self.placemark.postalCode : "",
        self.placemark.administrativeArea ? self.placemark.administrativeArea : "",
        self.placemark.country ? self.placemark.country : "")
        */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
