//
//  TravelogueViewController.swift
//  Travelogue
//
//  Created by Patrick McIntosh on 12/1/20.
// A bit of the code stemmed/altered from https://www.youtube.com/watch?v=SbfBTp20_tk&list=PLTQyl3JwSx0K4HoZM1Nyv_-WWouAPnqhb for reference

import UIKit
import CoreData

class TravelogueViewController: UIViewController {

    
    @IBOutlet weak var entriesTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var trip: Trip?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

                dateFormatter.timeStyle = .long
                dateFormatter.dateStyle = .long
    }
    
        override func viewWillAppear(_ animated: Bool) {
            self.entriesTableView.reloadData()
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    @IBAction func addNewEntry(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showEntry", sender: self)

    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let destination = segue.destination as? AddEntryViewController else{
                return
            }
            
            if let row = entriesTableView.indexPathForSelectedRow?.row{
                destination.entry = trip?.entries?[row]
            }
            destination.title = title
            destination.trip = trip
            
        }
    
        func deleteEntry(at indexPath: IndexPath){
            guard let entry = trip?.entries?[indexPath.row],   let managedContext = entry.managedObjectContext else {
                return
            }
    
            managedContext.delete(entry)
    
            do{
                try managedContext.save()
                entriesTableView.deleteRows(at: [indexPath], with: .automatic)
    
            } catch{
                print("Could not delete entry")
    
                entriesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    
}

extension TravelogueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entriesCell", for: indexPath) as? EntriesTableViewCell
        
        if let entry = trip?.entries?[indexPath.row] {
            

            cell?.titleLabel?.text = entry.title
            cell?.contentLabel?.text = entry.content
            
            
            if let date = entry.rawDate{
                cell?.dateLabel?.text = dateFormatter.string(from: date)
            }
        }
        
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//           deleteEntry(at: indexPath)
//        }
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            deleteEntry(at: indexPath)
        }
    }
    
    
}

extension TravelogueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
}



