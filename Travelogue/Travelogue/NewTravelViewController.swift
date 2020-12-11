//
//  NewTravelViewController.swift
//  Travelogue
//
//  Created by Patrick McIntosh on 12/9/20.
// A bit of the code stemmed/altered from https://www.youtube.com/watch?v=SbfBTp20_tk&list=PLTQyl3JwSx0K4HoZM1Nyv_-WWouAPnqhb for reference

import UIKit
import CoreData
class NewTravelViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveTrip(_ sender: Any) {
     
        let trip = Trip(title: titleTextField.text ?? "")
        
        do {
            try trip?.managedObjectContext?.save()
            self.navigationController?.popViewController(animated: true)
        } catch{
            print("Could not save trip")
        }
    }
}

extension NewTravelViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
