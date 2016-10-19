//
//  MyRestaurantTableViewCell.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 03/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class MyRestaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
