//
//  Image2CollectionViewCell.swift
//  app
//
//  Created by sina on 9.11.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import UIKit

class EventImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelTypeOfEvent: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    func setup(url: String, collectionViewName: String) {
        if let url = url.toURL() {
            eventImage.load(url: url)
            labelTypeOfEvent.text = collectionViewName
        }
    }
}
