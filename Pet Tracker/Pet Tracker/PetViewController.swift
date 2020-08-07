//
//  PetViewController.swift
//  Pet Tracker
//
//  Created by Sarah covey on 2/21/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//

import UIKit
import CoreData

class PetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var managedObjectContext: NSManagedObjectContext!;
    
    var owner: Friend?;
    var pets: [Pet] = [];
        func retrievePets() -> [Pet]{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Unable to access App Delegate")}
            let context = appDelegate.persistentContainer.viewContext;
            
            do {
                return try context.fetch(Pet.fetchRequest());
            } catch let error as NSError {
                fatalError("Unable to fetch Pets, \(error.description)")
            }
        }
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let friendsPets = owner?.pets?.allObjects as! [Pet];
        pets = friendsPets;
        collectionView.reloadData();
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCell", for: indexPath) as! PetCollectionViewCell;
            let pet = pets[indexPath.row];
            // configure cell
            cell.update(with: pet);
            return cell;
    }

    @IBAction func addPetUnwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "addPetUnwind" else { return }
        
        let friendsPets = owner?.pets?.allObjects as! [Pet];
        pets = friendsPets;
        self.collectionView.reloadData();
    }
    
    @IBAction func cancelPetUnwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "cancelPetUnwind" else { return }
        
        let friendsPets = owner?.pets?.allObjects as! [Pet];
        pets = friendsPets;
        self.collectionView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addPetForm"){
            let addPetTableViewController = segue.destination as! AddPetTableViewController
                addPetTableViewController.owner = owner;
        }
    }

}



