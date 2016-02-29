//
//  InstaCell.swift
//  InstaBeast
//
//  Created by Rupin Bhalla on 2/27/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class InstaCell: UITableViewCell
{

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
