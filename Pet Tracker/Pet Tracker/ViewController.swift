//
//  ViewController.swift
//  Pet Tracker
//
//  Created by Sarah covey on 2/14/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource {
    
    var managedObjectContext: NSManagedObjectContext!
    var searchTerm: String = "";
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var friends: [Friend] = [];
        func retrieveFriends() -> [Friend]{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Unable to access App Delegate")}
            let context = appDelegate.persistentContainer.viewContext;
            
            do {
                return try context.fetch(Friend.fetchRequest());
            } catch let error as NSError {
                fatalError("Unable to fetch Friends, \(error.description)")
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self;
        friends = retrieveFriends();
        collectionView.reloadData();
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCell", for: indexPath) as! FriendCollectionViewCell;
        let friend = friends[indexPath.row];
        
//         configure cell
        cell.update(with: friend);
        
        return cell;
    }
    
    
//      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
////          let indexPath = collectionView.indexPathForSelectedRow!
//          let friend = friends[indexPath.row]
//          let petViewController = segue.destination as! PetViewController
//          petViewController.owner = friend;
//      }
    
    @IBAction func addUnwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "addUnwind" else { return }
        friends = retrieveFriends();
        self.collectionView.reloadData();
    }
    
    @IBAction func cancelUnwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "cancelUnwind" else { return }
        self.collectionView.reloadData();
    }


    func retrieveSearchResults() -> [Friend]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Unable to access App Delegate")
        }
        let context = appDelegate.persistentContainer.viewContext;
        
//        let predicate1 = NSPredicate(format: "firstName like %@")
//        let predicate2 = NSPredicate(format: "lastName like %@")
//        let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1,predicate2])
//                    print("\(searchTerm)");
        if !searchTerm.isEmpty {
            do {
                let searchPhrase = searchTerm.components(separatedBy: " ")
                print("made it to search block, not displaying results for some reason");
                let friendsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend");
                

                if searchPhrase.count == 1 {
                    friendsFetch.predicate = NSPredicate(format: "(firstName contains[c] %@) OR (lastName contains[c] %@) OR (email contains[c] %@)", searchPhrase[0], searchPhrase[0], searchPhrase[0]);
                    friends = try context.fetch(friendsFetch) as! [Friend];
                } else if searchPhrase.count == 2 {
                    friendsFetch.predicate = NSPredicate(format: "(firstName contains[c] %@) AND (lastName contains[c] %@)", searchPhrase[0], searchPhrase[1]);
                    friends = try context.fetch(friendsFetch) as! [Friend];
                } else {
                    friends = [];
                }
                         
 
             } catch {
                 fatalError("Failed to fetch friends: \(error)")
             }
        } else {
            friends = retrieveFriends();
            print("failed to fetch friends, in else clause");
        }

        return friends;
        
    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
//
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Unable to access App Delegate")}
//        let context = appDelegate.persistentContainer.viewContext;
//
//        let searchTerm = searchTextField.text ?? "";
//        if !searchTerm.isEmpty {
//            let friendsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
//            friendsFetch.predicate = NSPredicate(format: "firstName = %@", searchTerm);
//            //        print(searchResults);
//                    do {
//                        friends = try context.fetch(friendsFetch) as! [Friend];
////                        return friends;
//                    } catch {
//                        fatalError("Failed to fetch friends: \(error)")
//                    }
//        }
////           friends = retrieveSearchResults();
//           self.collectionView.reloadData();
//       }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "petsSegue"){
            let petViewController = segue.destination as! PetViewController
            if let cell = sender as? UICollectionViewCell,
               let indexPath = self.collectionView.indexPath(for: cell) {
                  let owner = friends[indexPath.row]
                print(owner);
                petViewController.owner = owner;
            }
        }
    }
}


extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
            searchTerm = searchTextField.text ?? "";
            friends = retrieveSearchResults();
            self.collectionView.reloadData();
//            searchTextField.resignFirstResponder()
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            friends = retrieveFriends();
            self.collectionView.reloadData();
//            searchTextField.resignFirstResponder()
        
    }
}

