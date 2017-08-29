//
//  ReviewViewController.swift
//  places
//
//  Created by Adrian Loarri on 18/07/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var ratingStackView: UIStackView!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    
    @IBOutlet var firstBtn: UIButton!
    
    @IBOutlet var secondBtn: UIButton!
    
    @IBOutlet var thirdBtn: UIButton!
    
    
    
    
    
    var ratingSelected : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PARA HACER EFECTO DE DIFUMINADO
        
        let blurEffect = UIBlurEffect (style: .dark)
        let blurEffectView = UIVisualEffectView (effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        /* PARA HACER ANIMACIONES DE ESCALADO
        
        ratingStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)*/
        
        /* PARA HACER ANIMACIONES DE POSICION ABAJO-ARRIBA
        
        ratingStackView.transform = CGAffineTransform(translationX: 0.0, y: 700.0)*/
        
        
        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        // PARA HACER ANIMACIONES DE POSICION ABAJO-ARRIBA
        
        let translation = CGAffineTransform(translationX: 0.0, y: 700.0)
        
        //ratingStackView.transform = scale.concatenating(translation) //combinar escalado con translacion
        
        self.firstBtn.transform = scale.concatenating(translation)
        self.secondBtn.transform = scale.concatenating(translation)
        self.thirdBtn.transform = scale.concatenating(translation)

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // INSTRUCCION PARA REGRESAR A TAMAÑO ORIGINAL CON ANIMACION
        
        /*UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)*/
        
        // INSTRUCCION PARA REGRESAR A TAMAÑO ORIGINAL CON ANIMACION REBOTE PARA CADA BOTON
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.firstBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.secondBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (success) in
                UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.thirdBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
            })
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //ACCION PARA BOTÓN VOLVER ATRÁS 
    /*@IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }*/
   
    // ACCION PARA TODOS LOS BOTONES DE RATING
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        switch sender.tag{
        case 1:
            ratingSelected = "dislike"
        case 2:
            ratingSelected = "good"
        case 3:
            ratingSelected = "great"
        default:
            break
    }
   
  
    
    
    
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
        
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
