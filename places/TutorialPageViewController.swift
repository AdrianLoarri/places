//
//  TutorialPageViewController.swift
//  places
//
//  Created by Adrian Loarri on 24/08/2017.
//  Copyright © 2017 Adrian Loarri. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var tutorialSteps : [tutorialStep] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // SE CONFIGURAN LOS VIEWS CONTROLLER DEL TUTORIAL
        
        let firstStep = tutorialStep(index: 0, heading: "Personalize", content: "Create new places and locations in few seconds", image: #imageLiteral(resourceName: "iphone"))
        self.tutorialSteps.append(firstStep)
        let secondStep = tutorialStep(index: 1, heading: "Find", content: "Localize your favorite places in the map", image: #imageLiteral(resourceName: "iphone"))
        self.tutorialSteps.append(secondStep)
        let thirdStep = tutorialStep(index: 2, heading: "Discover", content: "Discover amazing places near to you and share them with your friends", image: #imageLiteral(resourceName: "iphone"))
        self.tutorialSteps.append(thirdStep)
        
        // SE DEFINE QUIEN VA SER LA PRIMERA PAGINA DEL TUTORIAL
        dataSource = self
        if let startVC = self.pageViewController(atIndex: 0){
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
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
    
    
    // FUNCION MOVER HACIA ADELANTE LAS PAGINAS DEL TUTORIAL 
    func forward(toIndex: Int){
        if let nextVC = self.pageViewController(atIndex: toIndex + 1){
            self.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

}

//SE CREA ESTA EXTENSION PARA CONFIGURAR TODA LA INFORMACION QUE CONTIENE EL TUTORIALPAGE
extension TutorialPageViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //SE RECUPERA LA POSICION QUE VIENE EN EL INDEX AHORA MISMOVIEW CONTROLLER
        var index = (viewController as! TutorialViewController).tutorialStep.index
        index += 1
        return self.pageViewController(atIndex: index)
        
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialViewController).tutorialStep.index
        index -= 1
        return self.pageViewController(atIndex: index)

    }
    
    func pageViewController(atIndex: Int) -> TutorialViewController?{
        if atIndex == NSNotFound || atIndex < 0 || atIndex >= self.tutorialSteps.count{
            return nil
        }
    if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughtPageContent" ) as? TutorialViewController {
        pageContentViewController.tutorialStep = self.tutorialSteps[atIndex]
        
        return pageContentViewController
    }
    
    return nil
    
  }
    
    /*ESTE METODO CUENTA CUANTAS PAGINAS POR MEDIO DE LOS INDICADORES CIRCULARES HAY EN EL TUTORIAL
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.tutorialSteps.count
    }
    //MUESTRA EL ESTADO ACTIVO DE LA PAGINA EN LA QUE NOS ENCONTRAMOS
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let pageContentVC = storyboard?.instantiateViewController(withIdentifier: "WalkthroughtPageContent") as? TutorialPageViewController{
            return pageContentVC.tutorialSteps.index(after: 0)
        }
        return 0
    }*/


}












