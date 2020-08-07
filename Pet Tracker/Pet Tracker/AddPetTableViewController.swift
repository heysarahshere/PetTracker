//
//  AddPetTableViewController.swift
//  Pet Tracker
//
//  Created by Sarah covey on 2/27/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//

import UIKit
import CoreData

class AddPetTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    var managedObjectContext: NSManagedObjectContext!
    var viewController = ViewController.self;
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
    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var animalKindLabel: UILabel!
    @IBOutlet weak var animalKindPicker: UIPickerView!
    @IBOutlet weak var dobPickerLabel: UILabel!
    @IBOutlet weak var dobPicker: UIDatePicker!
    
    var owner: Friend?;
    var kinds = ["Cat",
                 "Dog",
                 "Rabbit",
                 "Ferret",
                 "Hamster",
                 "Mouse",
                 "Rat",
                 "Sugar Glider",
                 "Snake",
                 "Lizard",
                 "Turtle",
                 "Tortoise",
                 "Bird",
                 "Goat",
                 "Alpaca",
                 "Pig",
                 "Spider",
                 "Frog"];
    
    let animalKindPickerCellIndexPath = IndexPath( row: 1, section: 1);
    let dobPickerCellIndexPath = IndexPath( row: 1, section: 2);
    
    var isAnimalKindPickerShown: Bool = false {
        didSet {
            animalKindPicker.isHidden = !isAnimalKindPickerShown;
        }
    }
    var isDobPickerShown: Bool = false {
        didSet {
            dobPicker.isHidden = !isDobPickerShown;
        }
    }
    
    
       override func viewDidLoad() {
           super.viewDidLoad()
       }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (animalKindPickerCellIndexPath.section, animalKindPickerCellIndexPath.row):
            return isAnimalKindPickerShown ? 244.0 : 0.0
       case (dobPickerCellIndexPath.section, dobPickerCellIndexPath.row):
            return isDobPickerShown ? 244.0 : 0.0
        default:
            return 44.0
        }
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           
           switch (indexPath.section, indexPath.row) {

            case (animalKindPickerCellIndexPath.section, animalKindPickerCellIndexPath.row - 1):
                if isAnimalKindPickerShown {
                    isAnimalKindPickerShown = false
                } else if isDobPickerShown {
                    isDobPickerShown = false
                    isAnimalKindPickerShown = true
                } else {
                    isAnimalKindPickerShown = true
                }
                
                tableView.beginUpdates()
                tableView.endUpdates()
                
            case (dobPickerCellIndexPath.section, dobPickerCellIndexPath.row - 1):
                if isDobPickerShown {
                    isDobPickerShown = false
                } else if isAnimalKindPickerShown {
                    isAnimalKindPickerShown = false
                    isDobPickerShown = true
                } else {
                    isDobPickerShown = true
                }
                
                tableView.beginUpdates()
                tableView.endUpdates()
            
           default:
               break
           }

       }

    
    // MARK: - animalKindPicker Datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kinds.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kinds[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        animalKindLabel.text = kinds[row];

    }
    
    @IBAction func dobPickerValuesChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dobPickerLabel.text = dateFormatter.string(from: dobPicker.date)

    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    
        let name = "\(petName.text ?? "")";
        let animal_kind = animalKindLabel.text ?? "";
        let dobChecker = dobPickerLabel.text ?? "";
        
   

        if !name.isEmpty && animal_kind != "Choose..." && dobChecker != "Choose..." {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Unable to access App Delegate")}
            let context = appDelegate.persistentContainer.viewContext;

            let dob = dobPicker.date;
            let pet = Pet(entity: Pet.entity(), insertInto: context);
            pet.name = name;
            pet.animalKind = animal_kind;
            pet.dob = dob;
            pet.owner = owner;
            
            appDelegate.saveContext();
            pets = retrievePets();
                
            performSegue(withIdentifier: "addPetUnwind", sender: nil)
       } else {newAlert();}
    }
    
        func newAlert() {
            let alert = UIAlertController(title: "Error", message: "Please fill out all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
}
