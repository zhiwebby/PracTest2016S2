//
//  EstateTableViewCell.swift
//  PracTest2016S2
//
//  Created by iOS on 8/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class EstateTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var populationLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
