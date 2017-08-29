//
//  DetailViewController.swift
//  places
//
//  Created by Adrian Loarri on 16/07/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {
    
    
    @IBOutlet var placeImageView: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var ratingBtn: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    
    var place : Place!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MUESTRA LA IMAGEN Y EL TITULO
        self.title = self.place.name

        //self.nameLabel.text = self.place.name!
        
        
        /*self.placeImageView.image = self.place.image*/
        self.placeImageView.image = UIImage(data: self.place.image! as Data)
        
        
        // EDITA EL COLOR DEL TABLEVIEW
        
        self.tableView.backgroundColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        
        // INSTRUCCION PARA QUE TODO LO QUE VENGA DESPUES DE LA ULTIMA CELDA DESAPAREZCA
        
        self.tableView.tableFooterView = UIView (frame: CGRect.zero)
        
        // COLOR DEL SEPARADOR
        
        self.tableView.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        
        //DIMENSIONA DE FORMA AUTOMATICA EL TAMAÑO DE LAS CELDAS
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //SE AGREGAN LAS IMAGENES DE FAVORITOS AL INICIALIZAR
        let image = UIImage(named: self.place.rating!)
        self.ratingBtn.setImage(image, for: .normal)
        
      
        
        
        // OCULTA Y MUESTRA BARRA DE NAVEGACION TOP
        func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.hidesBarsOnSwipe = false
            navigationController?.setToolbarHidden(false, animated: true)
        }
        
        
        
        // OCULTAR BARRA DE ESTADO
        
        func prefersStatusBarHidden() -> Bool {
            return true
        }
 
        
        // Do any additional setup after loading the view.
    }
    
    
    // METODO PARA QUE EL SEGUE MUESTRE EL MAPA
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destination = segue.destination as! MapViewController
            destination.place = self.place
        }
        
        
    }
    

    
    //INSTRUCCION PARA CERRAR LA PANTALLA DE RATING
    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewVC = segue.source as? ReviewViewController {
            
            if let rating = reviewVC.ratingSelected {
                self.place.rating = rating
                let image = UIImage(named: self.place.rating!)
                self.ratingBtn.setImage(image, for: .normal)
                
                // INSTRUCCION PARA QUE LOS CAMBIOS EN RATING SE GUARDEN Y PERSISTAN CADA VEZ QUE SE ABRE LA APP
                if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                    let context = container.viewContext
                    do{
                        try context.save()
                    } catch {
                        print ("Error\(error)")
                    }
                }
                
            }
        }
    
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    //RECIBE LA INFORMACION Y LA MUESTRA EN LA TABLA VIEW POR CADA ROW
extension DetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // MUESTRA LA INFORMACION DE CADA CELL EN REFERENCIA AL ARCHIVO RECIPE DETAIL TABLE VIEW CELL
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceDetailTableViewCell", for: indexPath) as! PlaceDetailTableViewCell
        
        // INSTRUCCION PARA ELIMINAR EL COLOR DEL CELL
        
        cell.backgroundColor = UIColor.clear
        
   
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Name:"
                cell.valueLabel.text = self.place.name
            case 1:
                cell.keyLabel.text = "Place:"
                cell.valueLabel.text = self.place.type
            case 2:
                cell.keyLabel.text = "Location:"
                cell.valueLabel.text = self.place.location
            case 3:
                cell.keyLabel.text = "Phone:"
                cell.valueLabel.text = self.place.phone
            case 4:
                cell.keyLabel.text = "Website:"
                cell.valueLabel.text = self.place.website
            default: break
            }
        
        
        return cell
    }
}
extension DetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            // REFIERE AL CASE LOCATION ARRIBA
            self.performSegue(withIdentifier: "showMap", sender: nil)
        
        case 3:
            // LLAMAR O MANDAR SMS EN EL LUGAR EN CUESTION
            let alertController = UIAlertController(title: "Contact with\(self.place.name)",
                                                    message: "Do you want call or send SMS \(String(describing: self.place.phone!))?",
                                                    preferredStyle: .actionSheet)
            
            let callAction = UIAlertAction(title: "Call", style: .default, handler: { (action) in
                //LOGICA DE LLAMAR A UN TELEFONO       +\(self.place.phone!)
                if let phoneURL = URL(string: "phone://\(String(describing: self.place.phone!))"){
                    let app = UIApplication.shared
                    
                    if app.canOpenURL (phoneURL){
                        app.open(phoneURL, options: [:], completionHandler: nil)
                    }
                }
            })
            alertController.addAction(callAction)
            
            let smsAction = UIAlertAction(title: "SMS", style: .default, handler: { (action) in
                //LOGICA DE MANDAR UN MESAJE
                if MFMessageComposeViewController.canSendText(){
                    let msg = "Hello from app PLACES by LOARRI Studio"
                    let msgVC = MFMessageComposeViewController()
                    msgVC.body = msg
                    msgVC.recipients = [self.place.phone!]
                    msgVC.messageComposeDelegate = self
                    
                    self.present(msgVC, animated: true, completion: nil)
                    
                }
            })
            alertController.addAction(smsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
        self.present(alertController, animated: true, completion: nil)
            
        case 4:
            //LOGICA PARA ABRIR UN SITIO WEB
            if let websiteURL = URL(string: self.place.website!){
                let app = UIApplication.shared
                if app.canOpenURL(websiteURL){
                    app.open(websiteURL, options: [:], completionHandler: nil)
            }
            
        }
        
        default:
            break
        }
        self.tableView.deselectRow(at: indexPath, animated: true)

    }
    
}

extension DetailViewController : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
        print(result)
    }
}






