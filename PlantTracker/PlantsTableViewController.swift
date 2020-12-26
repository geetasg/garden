//
//  PlantsTableViewController.swift
//  PlantTracker
//
//  Created by Aditi on 11/22/20.
//

// MARK: - Import UIKit
import UIKit
import UserNotifications
import CoreData

class PlantsTableViewController: UITableViewController, AddPlantViewControllerDelegate {
   
    func reloadPlants() {
        readData()
    }
    
    //func addPlantViewController(_ addPlantViewController: AddPlantViewController, //didAddPlant plant: Plant) {
        //plants.append(plant)
        //tableView.reloadData()
    //}
    
    var plants = [Plant]()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        /*
        let p1 = Plant(commonName: "mango", scientificName: "ben", variety: "Indian", whenToPlant: Date(), harvestTime: 600)
        plants.append(p1)
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("TableViewController viewWillAppearCalled")
 
        super.viewWillAppear(animated)
        readData()
    }
    
    func readData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = Plant.fetchRequest() as NSFetchRequest<Plant>
        do {
            plants = try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of \(error)")
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return plants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCellIdentifier", for: indexPath)

        // Configure the cell...
        
        let plant = plants[indexPath.row]
        
        let commonName = plant.commonName ?? ""
        let scientificName = plant.scientificName ?? ""
        let variety = plant.variety ?? ""
        cell.textLabel?.text =  variety + "" + commonName
        
        if let date = plant.whenToPlant as Date? {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    

    
}
