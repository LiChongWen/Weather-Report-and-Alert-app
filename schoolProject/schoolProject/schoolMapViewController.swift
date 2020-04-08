//
//  schoolMapViewController.swift
//  schoolProject
//
//  Created by Li arthur on 16/4/13.
//  Copyright © 2016年 Li arthur. All rights reserved.
//

import UIKit
import MapKit

class schoolMapViewController: UIViewController {

    @IBOutlet weak var schoolMap: MKMapView!{
        didSet{
            schoolMap.delegate = self
        }
    }
    let schoolLocation: String = "118.8183272677,32.0776074240"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeArr = schoolLocation.characters.split{$0 == ","}.map(String.init)
        if let lat = Double(placeArr[1]), lon = Double(placeArr[0]){
            let latDelta = 0.1
            let longDelta = 0.01
            let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let center:CLLocation = CLLocation(latitude: lat, longitude: lon)
            let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
            self.schoolMap.setRegion(currentRegion, animated: true)
            let objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = CLLocation(latitude: lat, longitude: lon).coordinate
            objectAnnotation.title = "南京林业大学"
            objectAnnotation.subtitle = "南京林业大学信息科技学院"
            
            self.schoolMap.addAnnotation(objectAnnotation)
            self.schoolMap.selectAnnotation(objectAnnotation, animated: true)
        }
        // Do any additional setup after loading the view.
    }

    
}

extension schoolMapViewController: MKMapViewDelegate{


    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuserId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuserId)
            as? MKPinAnnotationView
        if pinView == nil {
            //创建一个大头针视图
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            //设置大头针颜色
            //设置大头针点击注释视图的右侧按钮样式
            pinView?.leftCalloutAccessoryView = UIButton(frame:CGRect(x: 0, y: 0, width: 59, height: 59))
            print("1")
        }else{
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            pinView?.annotation = annotation
            print("2")
        }
        
        return pinView
        
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let button = view.leftCalloutAccessoryView as? UIButton{
            
            button.setImage(UIImage(named: "南林"), forState: .Normal)
            print("3")
        }
        print("4")
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
    }
}