//
//  EventCellController.swift
//  projektiFinal
//
//  Created by Ardit Zherka on 4/12/18.
//  Copyright © 2018 Ardit Zherka. All rights reserved.
//

import UIKit

class EventCellController: UITableViewCell {
    @IBOutlet weak var imgFotoja: UIImageView!
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
