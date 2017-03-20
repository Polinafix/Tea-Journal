//
//  TeaTableViewController.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 04/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData

class TeaTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,UISearchResultsUpdating{
    
  var teas:[TeaMO] = []
  var searchResults:[TeaMO] = []
  var searchController:UISearchController!
    //declare an instance variable for the fetched results controller
  var fetchResultController: NSFetchedResultsController<TeaMO>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.hidesBarsOnSwipe = true
        
        
        // Add a search bar
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search my collection..."
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 174.0/255.0, green: 164.0/255.0, blue: 191.0/255.0, alpha: 1.0)

        // Fetch data from data store
        let fetchRequest: NSFetchRequest<TeaMO> = TeaMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest:
                fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil,
                              cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    teas = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func controllerWillChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type:
        NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            teas = fetchedObjects as! [TeaMO]
        }
    }
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return teas.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TeaTableViewCell
        // Determine if we get the restaurant from search result or the original array
        let tea = (searchController.isActive) ? searchResults[indexPath.row]
            : teas[indexPath.row]
        
        // Configure the cell...
    
        
        cell.nameLabel.text = tea.name
        cell.typeLabel.text = tea.type
        cell.thumbnailImage.image = UIImage(data: tea.image
            as! Data)
        cell.brandLabel.text = tea.brand
        cell.accessoryType = tea.haveTried ? .checkmark : .none
       
        
        return cell
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath:
        IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    //add custom actions to the table view's row
    override func tableView(_ tableView: UITableView, editActionsForRowAt
        indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Trying the new tea " +
                    self.teas[indexPath.row].name! + " by " + self.teas[indexPath.row].brand!
                if let imageToShare = UIImage(data: self.teas[indexPath.row].image as!
                    Data) {
                    let activityController = UIActivityViewController(activityItems:
                        [defaultText, imageToShare], applicationActivities: nil)
                    
                    self.present(activityController, animated: true, completion: nil)
                }
        })
        // Delete button
        let deleteAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
                indexPath) -> Void in
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    let context = appDelegate.persistentContainer.viewContext
                    let teaToDelete = self.fetchResultController.object(at:
                        indexPath)
                    context.delete(teaToDelete)
                    appDelegate.saveContext()
                }
        })
        
        shareAction.backgroundColor = UIColor(red: 174.0/255.0, green: 164.0/255.0,
                                              blue: 191.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0,
                                               blue: 203.0/255.0, alpha: 1.0)
        return [deleteAction, shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTeaDetail" {
            //retrieve the selected row
            if let indexPath = tableView.indexPathForSelectedRow {
                //retrieve the destination controller
                let destinationController = segue.destination as!
                TeaDetailViewController
                destinationController.tea = (searchController.isActive) ?
                    searchResults[indexPath.row] : teas[indexPath.row]
                
            }
        }
    }
    
    func filterContent(for searchText: String) {
        searchResults = teas.filter({ (tea) -> Bool in
            if let name = tea.name, let brand = tea.brand, let type = tea.type {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || brand.localizedCaseInsensitiveContains(searchText)||type.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

   

}
