//
//  PetCollectionViewCell.swift
//  Pet Tracker
//
//  Created by Sarah covey on 2/21/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//

import UIKit
import CoreData

class PetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petKindLabel: UILabel!
    @IBOutlet weak var petDobLabel: UILabel!
    
    func update(with pet: Pet){
        petNameLabel.text = "\(pet.name ?? "")";
        petKindLabel.text = "\(pet.animalKind ?? "")";
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = .medium;
        petDobLabel.text = dateFormatter.string(from: pet.dob!);
    
    }
}
