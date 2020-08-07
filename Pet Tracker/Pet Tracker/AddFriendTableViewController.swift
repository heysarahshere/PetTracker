//
//  AddFriendTableViewController.swift
//  Pet Tracker
//
//  Created by Sarah covey on 2/21/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//

import UIKit
import CoreData

class AddFriendTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    var viewController = ViewController.self

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
    
    @IBOutlet weak var eyeColorPicker: UIPickerView!
    @IBOutlet weak var eyeColorPickerLabel: UILabel!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var colors = ["Light Blue",
                  "Dark Blue",
                  "Dark Green",
                  "Light Green",
                  "Light Brown",
                  "Dark Brown",
                  "Light Gray",
                  "Dark Gray",
                  "Gold"]
    
    let eyeColorPickerCellIndexPath = IndexPath( row: 1, section: 3)

    var isEyeColorPickerShown: Bool = false {
        didSet {
            eyeColorPicker.isHidden = !isEyeColorPickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel();
        
                switch colors[row] {
                    case "Light Green":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1);
                    return pickerLabel;
                    case "Dark Green":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1);
                    return pickerLabel;
                    case "Light Brown":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1);
                    return pickerLabel
                    case "Dark Brown":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.1258703044, green: 0.08202353283, blue: 0.01528828557, alpha: 1);
                    return pickerLabel
                    case "Light Gray":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1);
                    return pickerLabel
                    case "Dark Gray":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1);
                    return pickerLabel
                    case "Light Blue":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1);
                    return pickerLabel
                    case "Dark Blue":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1);
                    return pickerLabel
                    case "Gold":
                    pickerLabel.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1);
                    return pickerLabel
                default:
                    pickerLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
                    return pickerLabel
                }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eyeColorPickerLabel.text = colors[row];

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (eyeColorPickerCellIndexPath.section, eyeColorPickerCellIndexPath.row):
            return isEyeColorPickerShown ? 244.0 : 0.0
       default:
            return 44.0
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {

        case (eyeColorPickerCellIndexPath.section, eyeColorPickerCellIndexPath.row - 1):
            
            if isEyeColorPickerShown {
                isEyeColorPickerShown = false
            } else {
                isEyeColorPickerShown = true
            }
            self.tableView.beginUpdates()
            self.tableView.endUpdates()

        default:
            break
        }

    }

    @IBAction func addButtonTapped(_ sender: Any) {
    
        let firstName = firstNameLabel.text ?? ""
        let lastName = lastNameLabel.text ?? ""
        let email = emailLabel.text ?? ""
        let age = ageLabel.text ?? "";
        let eyeColor = eyeColorPickerLabel.text ?? "";
        

        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !age.isEmpty && eyeColor != "Choose..." {
                //save defaults
            if Int(age) != nil {
            if isValidEmail(email)
            {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Unable to access App Delegate")}
                let context = appDelegate.persistentContainer.viewContext;

                let friend = Friend(entity: Friend.entity(), insertInto: context);
                friend.firstName = firstName;
                friend.lastName = lastName;
                friend.age = Int16(age)!;
                friend.email = email;
                friend.eyeColor = eyeColor;
                
                appDelegate.saveContext();
                friends = retrieveFriends();
            
                performSegue(withIdentifier: "addUnwind", sender: nil)
             } else {emailAlert();}
            } else {ageAlert();}
       } else {newAlert();}
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "cancelUnwind", sender: nil)
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func newAlert() {
        let alert = UIAlertController(title: "Error", message: "Please fill out all fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func emailAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter a valid email address.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func ageAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter an integer age.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
