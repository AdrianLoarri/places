//
//  TutorialViewController.swift
//  places
//
//  Created by Adrian Loarri on 24/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var contentImageView: UIImageView!
    
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextBtn: UIButton!
    // LA CLASE TUTORIALSTEP TIENE UN MODELO DE DATOS PEQUEÑO, QUE SIMPLEMENTE ES UN OBJETO DE LA CLASE TUTORIALSTEP Y CUANDO SE INSTANCIE ESTA CLASE SE RELLENAN LAS ETIQUETAS Y LAS IMAGESVIEW QUE NOS LLEGUEN DE ACUERDO AL MODO DE DATOS

    var tutorialStep : tutorialStep!
    
    // PAGINACION
    
    /*var index = 0
    var heading = " "
    var content = " "
    var instructions = " "*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.tutorialStep.heading
        self.contentImageView.image = self.tutorialStep.image
        self.contentLabel.text = self.tutorialStep.content
        self.pageControl.currentPage = self.tutorialStep.index
        
        // CAMBIAR TITULO DE BOTON SIGUIENTE RESPECTO A PAGINAS
        
        switch self.tutorialStep.index{
            case 0...1:
            self.nextBtn.setTitle("Siguiente", for: .normal)
            case 2: self.nextBtn.setTitle("Empezar", for: .normal)
            default: break
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // METODO PARA QUE AL PULSAR BOTON SIGUIENTE SE MUEVA HACIA ADELANTE Y SE CIERRE, QUE SE CONECTA EN EL TUTORIALPAGEVIEWCONTROLLER CON LA FUNCION
    @IBAction func nextPressed(_ sender: UIButton) {
        switch self.tutorialStep.index{
        case 0...1:
            let pageViewController = parent as! TutorialPageViewController
            pageViewController.forward(toIndex: self.tutorialStep.index)
        case 2:
            //ESTA FUNCION SE CONECTARA CON LA FUNCION viewDidAppear EN VIEWCONTROLLER
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedTutorial")
            
            self.dismiss(animated: true, completion: nil)
        default: break
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

}
