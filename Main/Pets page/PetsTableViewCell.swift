//
//  PetsTableViewCell.swift
//  app
//
//  Created by sina on 13.12.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import UIKit

class PetsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPetName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        print("")
        // Initialization code
    }
    func setup(petname: String? ) {
        if let name = petname {
            labelPetName.text = name}

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("")
        // Configure the view for the selected state
    }
}
