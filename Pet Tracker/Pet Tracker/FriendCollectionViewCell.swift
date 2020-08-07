//
//  FriendCollectionViewCell.swift
//  Pet Tracker
//
//  Created by Sarah covey on 2/14/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//

import UIKit
import CoreData

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendAddressLabel: UILabel!
    @IBOutlet weak var friendAgeLabel: UILabel!
    @IBOutlet weak var friendEyeColorLabel: UILabel!
    
    
    func update(with friend: Friend) {
    
        switch friend.eyeColor {
        case "Light Green":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1);
        case "Dark Green":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1);
        case "Light Brown":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1);
        case "Dark Brown":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.1258703044, green: 0.08202353283, blue: 0.01528828557, alpha: 1);
        case "Light Gray":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1);
        case "Dark Gray":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1);
        case "Light Blue":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1);
        case "Dark Blue":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1);
        case "Gold":
        friendEyeColorLabel.text = "        ";
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1);
    default:
        friendEyeColorLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
    }
        friendNameLabel.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")";
    friendAddressLabel.text = "\(friend.email ?? "")";
    friendAgeLabel.text = "\(friend.age)";

 }
    
    override func awakeFromNib() {
        super.awakeFromNib();
//        layer.cornerRadius = 10;
//        contentView.layer.cornerRadius = layer.cornerRadius; // had to add
//        layer.shadowOpacity = 1;
//        layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
    }
    
}
