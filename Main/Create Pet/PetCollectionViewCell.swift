//
//  PetCollectionViewCell.swift
//  app
//
//  Created by sina on 7.12.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import UIKit

class PetCollectionViewCell: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var didSelectedPetImage: (() -> Void)?
    var didAddImage: (() -> Void)?
    @IBOutlet weak var imageViewPet: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let imageGestureRecognatizer = UIGestureRecognizer(target: self, action: #selector(actionAddPetImage))
        imageViewPet.addGestureRecognizer(imageGestureRecognatizer)
        print("")

        // Initialization code
    }
    func setup(url: String) {
        if let url = url.toURL() {
            imageViewPet.load(url: url)
        }
    }
    @IBAction func actionAddPetImage(_ sender: UIButton) {
        didAddImage?()
        }
    @IBAction func actionDeletePetImage(_ sender: UIButton) {
        didSelectedPetImage?()

    }
}
