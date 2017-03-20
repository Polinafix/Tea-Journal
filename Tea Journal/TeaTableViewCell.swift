//
//  TeaTableViewCell.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 04/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class TeaTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
