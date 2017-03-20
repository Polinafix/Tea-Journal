//
//  TeaDetailTableViewCell.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 05/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class TeaDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var detailFieldLabel:UILabel!
    @IBOutlet var detailValueLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
