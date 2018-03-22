//
//  ViewController.swift
//  AdaptivePresentationsTask
//
//  Created by Robert Berry on 3/22/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: Properties
    
   @IBAction func HolidayGreetingButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Holiday Greeting", message: "Please confirm that you would like a random holiday greeting printed to the console.", preferredStyle: .actionSheet)
        
        var greetings: [String] = ["Merry Christmas!", "Happy Easter!", "Happy Thanksgiving!", "Happy 4th of July!", "Happy New Year!", "Happy Halloween!", "Happy Valentine's Day!", "Happy St. Patrick's Day!"]
        
        func changeGreetingText() -> String {
            let greetingIndex = Int(arc4random_uniform(UInt32(greetings.count)))
            let greetingString = greetings[greetingIndex]
            
            return greetingString
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (alert) in print("The user has elected not to display a holiday greeting.")
        }
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {
            (alert) in print(changeGreetingText())
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(yesAction)
        
        alertController.popoverPresentationController?.sourceRect = sender.frame
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showPopOverButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InformationViewController")
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    // Method called when a view controller is being presented on a device that has compact width.
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .fullScreen
    }
    
    // Wraps our view controller in a navigation controller that has a Done bar button item that dismisses it.
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ViewController.dismissViewController))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
        
        return navigationController
    }
    
    @objc func dismissViewController() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

