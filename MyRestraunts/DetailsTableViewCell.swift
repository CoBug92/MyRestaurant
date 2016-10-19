//
//  DetailsTableViewCell.swift
//  MyRestraunts
//
//  Created by Богдан Костюченко on 08/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
