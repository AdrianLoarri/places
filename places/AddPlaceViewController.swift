//
//  AddPlaceViewController.swift
//  places
//
//  Created by Adrian Loarri on 15/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit
import CoreData

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textfieldName: UITextField!
   
    @IBOutlet var textfieldType: UITextField!
    @IBOutlet var textfieldLocation: UITextField!
    
    @IBOutlet var textfieldPhone: UITextField!
    @IBOutlet var textfieldWebsite: UITextField!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var rating : String?
    
    var place : Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // SE DELEGAN LAS FUNCIONES EN SI MISMO DE LOS CAMPOS DE TEXTO
        self.textfieldName.delegate = self as? UITextFieldDelegate
        self.textfieldType.delegate = self as? UITextFieldDelegate
        self.textfieldLocation.delegate = self as? UITextFieldDelegate
        self.textfieldPhone.delegate = self as? UITextFieldDelegate
        self.textfieldWebsite.delegate = self as? UITextFieldDelegate
    }
    //METODO PARA CAMBIAR COLORES DE BOTONES
    let defaultColor = UIColor(red: 142.0/255.0, green: 152.0/255, blue: 0.0/255.0, alpha: 1.0)
    let selectedColor = UIColor(red: 97.0/255.0, green: 104.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.rating = "dislike"
            self.button1.backgroundColor = selectedColor
            self.button2.backgroundColor = defaultColor
            self.button3.backgroundColor = defaultColor
        case 2:
            self.rating = "good"
            self.button1.backgroundColor = defaultColor
            self.button2.backgroundColor = selectedColor
            self.button3.backgroundColor = defaultColor
        case 3:
            self.rating = "great"
            self.button1.backgroundColor = defaultColor
            self.button2.backgroundColor = defaultColor
            self.button3.backgroundColor = selectedColor
        default:
            break
        }
        
    }
    
    //METODO PARA SALVAR LA IMAGEN SELECIONADA UNA VEZ COMPLETADOS LOS CAMPOS REQUERIDOS

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        
        if let name = self.textfieldName.text,
            let type = self.textfieldType.text,
            let location = self.textfieldLocation.text,
            let phone = self.textfieldPhone.text,
            let website = self.textfieldWebsite.text,
            let theImage = self.imageView.image,
            let rating = self.rating  {
            
            // LA CLASE UIAPPLICATION SE UTILIZA PARA ACCEDER A DATOS ESPECIFICOS DE LA APLICACION. SHARE PORQUE ES UNA INSTANCIA COMPARTIDA POR TODAS LAS APLICACIONES. PERSISTENT CONTAINER PARA PODER UTILIZARLO EN EL RESTO DE LA APP
            // DEL CONTAINER NOS QUEDAMOS CON EL VIEWCONTEXT QUE ES QUIEN SE ENCARGA DE ALMACENAR LA INFORMACION EN COREDATA
            
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                let context = container.viewContext
                
                // ESTA FUNCION AGREGA UN LUGAR COMPLETAMENTE VACIO
                
                self.place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
                
                self.place?.name = name
                self.place?.type = type
                self.place?.location = location
                self.place?.phone = phone
                self.place?.website = website
                self.place?.rating = rating
                
                self.place?.image = UIImagePNGRepresentation((theImage)) as NSData?
                
                 // CUANDO SE TRATA DE UNA OPERACION DELICADA APPLE OBLIGA A UTILIZAR ESTE METODO
                
                do {
                    try context.save()
                } catch {
                    print("A mistake occurred trying save Core Data")
                }
            }
    
    
    
            
            /* VERSION ANTERIOR DE COMO SE SALVABAN LUGARES
             
             self.place = Place(name: name, type: type, location: location, image: theImage, phone: phone, website: website)
            self.place!.rating = rating
            print(self.place!.name)*/
            
            //SI TODO SE COMPLETA NOS ENVIA AL VIEWCONTROLLER PRINCIPAL
            self.performSegue(withIdentifier: "unwindToMainViewController", sender: self)

         
        }  else {
            let alertController = UIAlertController(title: "It´s missing some information", message: "Check please that everything is complete", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        

}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            // HAY QUE GESTIONAR LA SELECCION DE LA IMAGEN DEL LUGAR DESDE LA LIBRERIA DEL USUARIO
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                // CONFIRMA QUE SOMOS EL DELEGADO
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            
            }
            
            
    }
        
        // ESTE METODO HACE QUE UNA VEZ QUE EL USUARIO SELECIONE UNA CELDA NO QUEDARA SELECCIONADA.
         tableView.deselectRow(at: indexPath, animated: true)
        
}
    //ESTE METODO PERMITE QUE LA IMAGEN QUE EL USUARIO HAYA SELECCIONADO DEL PICKER SEA PRESENTADA CON LAS SIGUIENTES CARACTERISTICAS EN EL IMAGE VIEW
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        // RESTRICCION PARA LA IMAGE VIEW, DE MODO QUE EL BORDE IZQUIERDO SEA IGUAL A CERO COMPARADO CON EL BORDE IZQUIERDO DE LA VISTA PRINCIPAL QUE LO CONTIENE.
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        
        leadingConstraint.isActive = true
        
        // RESTRICCION PARA LA IMAGE VIEW DERECHA
        
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        
        trailingConstraint.isActive = true
        
        // RESTRICCION PARA LA IMAGE VIEW ARRIBA
        
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        
        topConstraint.isActive = true
        
        // RESTRICCION PARA LA IMAGE VIEW ABAJO
        
        let bottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
        
        
    /* AL SER UNA TABLA ESTATICA POR LO TANTO EL CONTENIDO NO SERÁ GESTIONADO POR CODIGO, SINO POR LA INTERFAZ GRAFICA.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    //AMBOS METODOS SE AÑADEN A LAS TABLAS DINAMICAS, PERO EN ESTE CASO SE ELIMINAN
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }*/
    
    
    //METODO PARA OCULTAR EL TECLADO DESPUES DEL ENTER.
    func textfieldShouldReturn(_ textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
}

