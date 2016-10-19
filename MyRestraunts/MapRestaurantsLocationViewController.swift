//
//  MapRestaurantsLocationViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 11/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit
import MapKit

class MapRestaurantsLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        //с помощью этого из текста в ширину и долготу и наоборт
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            //если ошибки = 0 то выполням код дальше
            guard error == nil else { return }
            //записываем наш опциональный массив в другой массив
            guard let placemarks = placemarks else { return }
            let placemark =  placemarks.first!
            
            //add annotation
            let annotation = MKPointAnnotation()
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.location
            
            //если нет такого адреса то дальше код не сработает
            guard let location = placemark.location else { return }
            annotation.coordinate = location.coordinate
            
            //отображаем аннотации
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //проверяем является ли аннотация местомположения
        guard !(annotation is MKUserLocation)  else { return nil }
        
        //добавялем аннотационный вид. MKPinAnnotationView - добавляет иголку
        let annotationIdentifier = "CurrentPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        //если не получается переиспользовать аннотации то создаем вручную
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //можно отобразить доп информацию
            annotationView?.canShowCallout = true
        }
        
        //Add image
        let leftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftImage.image = UIImage(named: restaurant.image)
        annotationView?.leftCalloutAccessoryView = leftImage
        
        //изменяем цвет иголки
        annotationView?.pinTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        return annotationView
    }
}
