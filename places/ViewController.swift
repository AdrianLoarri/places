//
//  ViewController.swift
//  places
//
//  Created by Adrian Loarri on 05/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit
import CoreData

// EL NSFETCH... RECIBE LAS NOTIFICACIONES DE QUE UN OBJETO EN COREDATA FUE MODIFICADO, POR TANTO DELEGARA LA INFORMACION EN ESTE CASO PARA QUE SE ACTUALICE LA TABLA PRINCIPAL CON LOS LUGARES
class ViewController: UITableViewController {
    
    var places : [Place] = []
    // SE CREA ESTA VARIABLE NOTIFICAR CUANDO LOS DATOS CAMBIAN EN EL CORE DATA PLACES
    var fetchResultsController: NSFetchedResultsController<Place>!
    
    var searchResults : [Place] = []
    
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //ASIGNA A LA CLASE ACTUAL QUE SEA QUIEN SOBREESCRIBA LOS METODOS DEL DELEGADO
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        //CAMBIA EL TEXTO EN EL PLACEHOLDER DEL BUSCADOR
        self.searchController.searchBar.placeholder = "Search a interesting place"
        
        self.searchController.searchBar.tintColor = UIColor(red: 142.0/255.0, green: 152.0/255, blue: 0.0/255.0, alpha: 1.0)
        self.searchController.searchBar.barTintColor = UIColor.darkGray
        
        
        
        //SE HACE LA PETICION AL CORE DATA QUE NOS DE LOS DATOS EN PLACE
        let fetchRequest : NSFetchRequest<Place> = NSFetchRequest(entityName: "Place")
        //ESTE METODO ORDENA LA INFORMACION COMO LA QUEREMOS MOSTRAR
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        // CON ESTE ARRAY SE PUEDEN PEDIR QUE SE MUESTRE LA INFORMACION QUE QUEREMOS DENTRO DE LOS CORCHETES SEPARADOS CON COMAS, PERO EN ESTE CASO SOLO SE PUSO SORTDESCRIPTOR
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            let context = container.viewContext
            self.fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                self.places = fetchResultsController.fetchedObjects!
                
                //FUNCION PARA PRECARGAR INFORMACIÓN Y RECORDAR INFORMACION GUARDADA POR EL USUARIO EN ESTE CASO LA INFORMACION DE QUE YA SE HA VISTO EL TUTORIAL Y SUSTITUYE EL TRUCO DE ABAJO DE CARGAR LOS LUGARES PREDEFINIDOS. INFORMACION COMO EDAD, NIVEL DE JUGADOR, FECHA DE NACIMIENTO SE PUEDEN GUARDAR EN USERSDEFAULTS
                
                /*let defaults = UserDefaults.standard
                if !defaults.bool(forKey: "hasLoadedDefaultInfo") {
                    self.loadDefaultData()
                    defaults.set(true, forKey: "hasLoadedDeafaultInfo")
                }*/
                
                //TRUCO
                if self.places.count < 6 {
                    self.loadDefaultData()
                }
                
                
            } catch {
                print("Error: \(error)")
            }
        }
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem (title: "", style: .plain, target: nil, action: nil)

        
        /* CADA VEZ QUE SE RECARGA LA APP, RECUPERARA LOS DATOS DE LA ENTIDAD COREDATA PARA MOSTRAR EN LAS TABLAS CON ESTE METODO
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            let context = container.viewContext
            
            let request = NSFetchRequest<Place>(entityName: "Place")
            // METODO ALTERNATIVO let request : NSFetchRequest<Place> = Place.fetchRequest()
            do{
                self.places = try context.fetch(request)
                //self.tableView.reloadData()ESTE METODO RECARGA MANUALMENTE Y SERIA UN PROBLEMA SI FUERAN 100 TABLAS
            } catch {
                print("Error: \(error)")
            }
            
        }*/
        
        // MOFICA EL BOTON DE REGRESAR EN LA BARRA DEL MENU
        
        
        /*OCULTA LA BARRA DE NAVEGACION CUANDO DESLIZAMOS Y APARECE SI REGRESAMOS A TOP
         
         navigationController?.hidesBarsOnSwipe = true */
        
    
        // MUESTRA LOS SIGUIENTES DETALLES DECLARADOS EN EL ARCHIVO RECIPE
    
        /*var place = Place(name: "Ojen", type: "Village", location: "29610 Ojén, Málaga", image: #imageLiteral(resourceName: "ojen"), phone: "123456789", website: "ojen.es")
        places.append(place)
        
        place = Place(name: "Kremnica", type: "Village", location:"967 01 Slovakia", image: #imageLiteral(resourceName: "kremnica"), phone: "123456789", website: "kremnica.sk")
        places.append(place)
        
        place = Place(name: "Cottages", type: "Valley", location: "032 23 Kvačany, Slovakia", image: #imageLiteral(resourceName: "cottages"), phone: "123456789", website: "liptov.sk")
        places.append(place)
        
        place = Place(name: "Liptov", type: "Landscape", location: "032 23 Kvačany, Slovakia", image: #imageLiteral(resourceName: "liptov"), phone: "123456789", website: "liptov.sk")
        places.append(place)
        
        place = Place(name: "Kunsthaus", type: "Museum Art", location: "8020 Graz Austria", image: #imageLiteral(resourceName: "kunsthaus"), phone: "123456789", website: "kunsthaus.at")
        places.append(place)
        
        place = Place(name: "Art Kunsthaus", type: "Museum Art", location: "8020 Graz Austria", image: #imageLiteral(resourceName: "artkunsthaus"), phone: "123456789", website: "kunsthaus.at")
        places.append(place)
        
        place = Place(name: "Graz", type: "Street", location: "Freiheitspl. 2, 8010 Graz, Austria", image: #imageLiteral(resourceName: "graz"), phone: "123456789", website: "graz.at")
        places.append(place)*/
    }
    
    func loadDefaultData(){
        
        let names = ["Ojen", "Kremnica", "Cottages", "Liptov", "Kunsthaus", "Art Kunsthaus", "Graz"]
        let types = ["Village", "Village", "Valley", "Landscape", "Museum Art", "Museum Art", "Street"]
        let locations = ["29610 Ojén, Málaga", "967 01 Slovakia", "032 23 Kvačany, Slovakia", "032 23 Kvačany, Slovakia", "8020 Graz Austria", "8020 Graz Austria", "Freiheitspl. 2, 8010 Graz, Austria"]
        let phones = ["123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789",]
        let websites = ["http://www.loarri.com", "http://www.loarri.com", "http://www.loarri.com", "http://www.loarri.com", "http://www.loarri.com", "http://www.loarri.com", "http://www.loarri.com"]
        let images = [#imageLiteral(resourceName: "ojen"), #imageLiteral(resourceName: "kremnica"), #imageLiteral(resourceName: "cottages"), #imageLiteral(resourceName: "kunsthaus"), #imageLiteral(resourceName: "artkunsthaus"), #imageLiteral(resourceName: "artkunsthaus"), #imageLiteral(resourceName: "graz")]
        
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            let context = container.viewContext
            
            for i in 0..<names.count {
                
                let place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
                
                place?.name = names[i]
                place?.type = types[i]
                place?.location = locations[i]
                place?.phone = phones[i]
                place?.website = websites[i]
                place?.rating = "rating"
                
                place?.image = (UIImagePNGRepresentation(images[i]) as? NSData?)!
                //place?.image = UIImagePNGRepresentation(images[i]) as? NSData
                
                do {
                    try context.save()
                } catch {
                    print("A mistake occurred trying save Core Data")
                }
                
            }
            
        }
        
    }
    
    // OCULTA Y MUESTRA BARRA DE NAVEGACION TOP
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // INSTRUCCION PARA MOSTRAR EL TUTORIAL
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // METODO REFERIDO DEL TUTORIALVIEWCONTROLLER PARA QUE EL TUTORIAL NO SE MUESTRE DESPUES DE HABER SIDO VISTO UNA VEZ
        let defaults = UserDefaults.standard
        let hasViewedTutorial = defaults.bool(forKey: "hasViewedTutorial")
        
        if hasViewedTutorial {
            return
        }
        
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "walkthroughController") as? TutorialPageViewController {
            self.present(pageVC, animated: true, completion: nil)
        }

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK : - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // ESTA FUNCION DEVUELVE LOS RESULTADOS DE BUSQUEDA CONTANDO EL NUMERO DE FILAS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return self.searchResults.count
            } else {
                return self.places.count
            }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place : Place!
        
        if self.searchController.isActive{
                place = self.searchResults[indexPath.row]
        } else {
          place = self.places[indexPath.row]
        }
        
        
        
        let cellID = "PlaceCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        cell.thumbnailImageView.image = UIImage(data: place.image! as Data)
        cell.nameLabel.text = place.name
        cell.timeLabel.text = place.type        
        cell.ingredientsLabel.text = place.location
        
        /*if place.isfavourite {
         cell.accessoryType = .checkmark
         } else{
         cell.accessoryType = .none
         }*/
        
        /*cell.thumbnailImageView.layer.cornerRadius = 45.0
         cell.thumbnailImageView.clipsToBounds = true*/
        
        
        return cell
    }
    
    
    /* EDITAR CELDAS *******BORRAR******
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.places.remove(at: indexPath.row)
        }
        
        /*ESTA FORMA DE BORRAR LINEAS ES MAS EFECTIVA QUE DELETE ROW, PORQUE EL INDEXPATH SE ENCARGA DE ACTUALIZAR LA LISTA */
        
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
        
        // VERIFICAR POR IMPRESION
        
        for place in self.places{
            print(place.name)
        }
        
        
    }*/
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // COMPARTIR UIACTIVITYVIEWCONTROLLER MUESTRA DIFERENTES ACCIONES DE APPLE, COMO COPIAR EN PORTAPALES
        
        let shareAction = UITableViewRowAction (style: .default, title: "Share") { (action, indexPath) in
            let place : Place!
            
            if self.searchController.isActive{
                place = self.searchResults[indexPath.row]
            } else {
                place = self.places[indexPath.row]
            }
            
            
            
            let shareDefaultText = "I'm checking the place \(self.places[indexPath.row].name) in Loarri's app"
            
            /*let activityController = UIActivityViewController(activityItems: [shareDefaultText, place.image], applicationActivities: nil)*/
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, UIImage(data: place.image! as Data)!], applicationActivities: nil)
            
            
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        
        // **** BORRAR EN CORE DATA
        
        let deleteAction = UITableViewRowAction(style: .default, title: "delete") { (action, indexPath) in
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                let placeToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(placeToDelete)
                
                do{
                    try context.save()
                } catch {
                    print("Error \(error)")
                }
                
            }
        }
        
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255, alpha: 1.0)
        
        
        return [shareAction, deleteAction]
        
    }
    
    
    //MARK : - UITableViewDelegate
    
    // COMO LLAMAR UN SEGUE PARA QUE TRANSFIERA INFORMACIÓN DE OTRO VIEW CONTROLLER
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let place : Place!
                
                if self.searchController.isActive{
                    place = self.searchResults[indexPath.row]
                } else {
                    place = self.places[indexPath.row]
                }
                
                
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.place = place
                
                //METODO PARA OCULTAR LA TABLA
                destinationViewController.hidesBottomBarWhenPushed = true
                
            }
        }
    }
    // SEGUE PARA REGRESAR AL VIEWCONTROLLER PRINCIPAL Y AÑADIR LA IMAGEN A UN NUEVO RAW
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue){
        
        if segue.identifier == "unwindToMainViewController" {
            if let addPlaceVC = segue.source as? AddPlaceViewController {
                if let newPlace = addPlaceVC.place {
                    self.places.append(newPlace)
                    //self.tableView.reloadData()ESTE METODO RECARGA MANUALMENTE Y SERIA UN PROBLEMA SI FUERAN 100 TABLAS
        }
      }
    }
  }
    
    // PARAMETROS DE FILTRADO EN EL BUSCADOR
    func filterContentFor(textToSearch: String){
        
        self.searchResults = self.places.filter ({ (place) -> Bool in
            let nameToFind = place.name.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)
        return nameToFind != nil
    })
    }
    
    
}

extension ViewController: NSFetchedResultsControllerDelegate {
    // 1 ESTA FUNCION NOTIFICA AL FETCH QUE HABRÁN CAMBIOS
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    // 3 LOS POSIBLES CAMBIOS QUE PUEDEN OCURRIR
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                self.tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        }
        // NOTIFICA AL ARRAY QUE HA HABIDO UN CAMBIO Y QUIEN LO SABE ES EL CONTROLLER, POR TANTO ME QUEDO CON LOS FETCHOBJECTS Y SE HACE UN CASTING SOBRE PLACE.
        self.places = controller.fetchedObjects as! [Place]
    }
    
    // 2 ESTA FUNCION NOTIFICA QUE SE HAN TERMINADO LOS CAMBIOS Y QUE DEBE FINALIZAR
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}

extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            self.filterContentFor(textToSearch: searchText)
            self.tableView.reloadData()
        }
    }
}
