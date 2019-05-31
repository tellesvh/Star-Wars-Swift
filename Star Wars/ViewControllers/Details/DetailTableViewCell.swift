//
//  DetailTableViewCell.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 31/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
