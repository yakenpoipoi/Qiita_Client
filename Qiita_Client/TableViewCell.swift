//
//  TableViewCell.swift
//  Qiita_Client
//
//  Created by Yoshiki Kishimoto on 2019/02/24.
//  Copyright © 2019 Yoshiki Kishimoto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
