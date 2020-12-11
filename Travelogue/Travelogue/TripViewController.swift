//
//  TripViewController.swift
//  Travelogue
//
//  Created by Patrick McIntosh on 12/9/20.
// A bit of the code stemmed/altered from https://www.youtube.com/watch?v=SbfBTp20_tk&list=PLTQyl3JwSx0K4HoZM1Nyv_-WWouAPnqhb for reference

import UIKit
import CoreData

class TripViewController: UIViewController {

    @IBOutlet weak var tripsTableView: UITableView!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do{
            trips = try managedContext.fetch(fetchRequest)
            tripsTableView.reloadData()
        } catch{
            print("Couldn't fetch")
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TravelogueViewController, let selectedRow = self.tripsTableView.indexPathForSelectedRow?.row else{
                return
        }
//        destination.trip
        destination.trip = trips[selectedRow]
        
    }
    
    func deleteTrip(at indexPath: IndexPath){
        let trip = trips[indexPath.row]
        
        guard let managedContext = trip.managedObjectContext else{
            return
        }
        
        managedContext.delete(trip)
        
        do{
            try managedContext.save()
            
            trips.remove(at: indexPath.row)
            
            tripsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch{
            print("Could not delete")
            
            tripsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

}

extension TripViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips [indexPath.row]
        cell.textLabel?.text = trip.title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteTrip(at: indexPath)
        }
    }
}
