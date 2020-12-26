//
//  ViewController.swift
//  PlantTracker
//
//  Created by Aditi on 10/16/20.
//

import UIKit
import UserNotifications
import CoreData

protocol AddPlantViewControllerDelegate {
    func reloadPlants()
}

// Controller takes the UI input and puts it into a class instance.


class AddPlantViewController: UIViewController {
    
    @IBOutlet var commonNameTextField: UITextField!
    @IBOutlet var scientificNameTextField: UITextField!
    @IBOutlet var variety: UITextField!
    @IBOutlet var whenToPlantPicker: UIDatePicker!
    @IBOutlet var whenToHarvestTextField: UITextField!
    
    var delegate: AddPlantViewControllerDelegate?
   
    func notify(commonNameOfPlant: String, scientificNameOfPlant: String, whenToPlantThePlant: Date) {
        
        let message = "Time to plant! Common name: \(commonNameOfPlant), Scientific name: \(scientificNameOfPlant)"
        let content = UNMutableNotificationContent()
        content.body = message
        content.sound = UNNotificationSound.default
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: whenToPlantThePlant)
        let dt = DateComponents()
        dateComponents.hour = dt.hour
        dateComponents.minute = dt.minute?.advanced(by: 1)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
       
        //if let identifier = newPlant.id
        let identifier = "planttracker"
        print("Created notification for \(dateComponents)")
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request, withCompletionHandler: { (error : Error?) in
            
            if error != nil {
                print("something went wrong")
            } else {
                print("Completed notification scheduling")
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Do any additional setup after loading the view
        whenToPlantPicker.minimumDate = Date()
    }
    @IBAction func saveTapped( _ sender: UIBarButtonItem) {
        
        let commonNameOfPlant = commonNameTextField.text ?? ""
        let scientificNameOfPlant = scientificNameTextField.text ?? ""
        let varietyOfPlant = variety.text ?? ""
        let whenToPlantThePlant = whenToPlantPicker.date
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlant = Plant(context: context)
        newPlant.commonName = commonNameOfPlant
        newPlant.scientificName = scientificNameOfPlant
        newPlant.whenToPlant = whenToPlantThePlant
        newPlant.variety = varietyOfPlant
        newPlant.plantId = UUID().uuidString
        

        //FIXME ht can be null if user did not enter a number
        
        do {
            try context.save()
        } catch let error {
            print("Coudn't save because of \(error)")
        }
        
        delegate?.reloadPlants()
        
        notify(commonNameOfPlant: commonNameOfPlant, scientificNameOfPlant: scientificNameOfPlant, whenToPlantThePlant: whenToPlantThePlant)

        
        print("Dismissing")
        dismiss(animated: true, completion: nil)
    
    }
    
    func completionRoutine() {
        print("Cancled")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: completionRoutine)
    }
    
}



