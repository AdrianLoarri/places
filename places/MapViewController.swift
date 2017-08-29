//
//  MapViewController.swift
//  places
//
//  Created by Adrian Loarri on 09/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var place: Place!

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        self.mapView.showsScale = true
        self.mapView.isZoomEnabled = true
        self.mapView.showsTraffic = true
        self.mapView.showsCompass = true
        self.mapView.showsBuildings = true
        self.mapView.showsUserLocation = true
        
        print("The map should show"+place.name)
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place.location) { [unowned self] (placemarks, error) in
            if error == nil {
                // PROCESAR LOS POSIBLES ERRORES
                for placemark in placemarks! {
                    
                    // METODO PARA MOSTRAR EL PINCHO Y LA ANOTACION EN EL MAPA
                    let annotation = MKPointAnnotation()
                    annotation.title = self.place.name
                    annotation.subtitle = self.place.type
                    annotation.coordinate = (placemark.location?.coordinate)!
                    
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                }
            } else {
                print("There´s a mistake: \(String(describing: error?.localizedDescription))")
            }
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// EN CADA LOCALIZACION DEL MAPA SE LLAMA ESTE METODO, SE CONFIGURA LA VISTA PARA UNA ANOTACION CONCRETA
// LA EXTENSION SE CREA COMO DELEGADO DEL MAPVIEWCONTROLLER PARA QUE AHI MUESTRE LA IMAGEN
extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        // SI EL TIPO DE ANOTACION ES LA DEL USUARIO NO SE HACE NADA
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        // SI NO, SE CREA UN PINCHO CON UN IDENTIFICADOR EN ESTE CASO LA VAR ANNOTATIONVIEW
        var annotationView : MKPinAnnotationView? = (self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView)
        // SI LA VISTA ES NULA QUIERE DECIR QUE NUNCA HA SIDO CONFIGURADA Y POR TANTO SE CREA DESDE CERO, CON LA FUNCIÓN DE SER UNA VISTA ACCESORIA ADICIONAL
        if annotationView == nil{
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        }
        // SE CONFIGURA LA IMAGEN COMO UNA IMAGEN CON TAMAÑO ESPECIFICO Y POSICIONADA A LA IZQUIERDA
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        // CUANDO SE ROMPE LA APP POR EL CORE DATA SE DEBE DE MODIFICAR LOS CONSTRUCTORES PARA TRANSFORMAR EL OBJETO DE TIPO NSDATA A IMAGENES
        //imageView.image = self.place.image se cambia por
        imageView.image = UIImage(data: self.place.image! as Data)
        annotationView?.leftCalloutAccessoryView = imageView
        
        //CAMBIAR COLOR PIN
        annotationView?.pinTintColor = UIColor.black
        
        //SE DEVUELVE AL FINAL DEL METODO
        return annotationView
    }
    
    
}
















