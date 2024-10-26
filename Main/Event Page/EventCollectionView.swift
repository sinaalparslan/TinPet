//
//  HorizontalCollectionView.swift
//  app
//
//  Created by sina on 9.11.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import UIKit
class EventCollectionView: UIViewController {
    @IBOutlet weak var collectionViewPetsHealts: UICollectionView!
    @IBOutlet weak var collectionViewPetsTraining: UICollectionView!
    @IBOutlet weak var collectionViewPetsCompetitions: UICollectionView!
    @IBOutlet weak var collectionViewPetsWalks: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewPetsWalks.delegate = self
        collectionViewPetsWalks.dataSource = self

        collectionViewPetsCompetitions.delegate = self
        collectionViewPetsCompetitions.dataSource = self

        collectionViewPetsTraining.delegate = self
        collectionViewPetsTraining.dataSource = self

        collectionViewPetsHealts.delegate = self
        collectionViewPetsHealts.dataSource = self

        registerCollectionViewCells()

    }
}
extension  EventCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func registerCollectionViewCells() {

        collectionViewPetsWalks.register(UINib(nibName: "EventImageCollectionViewCell",
                                               bundle: nil), forCellWithReuseIdentifier: "EventImageCollectionViewCell")
        collectionViewPetsCompetitions.register(UINib(nibName: "EventImageCollectionViewCell",
                                                      bundle: nil), forCellWithReuseIdentifier: "EventImageCollectionViewCell")
        collectionViewPetsTraining.register(UINib(nibName: "EventImageCollectionViewCell",
                                                  bundle: nil), forCellWithReuseIdentifier: "EventImageCollectionViewCell")
        collectionViewPetsHealts.register(UINib(nibName: "EventImageCollectionViewCell",
                                                bundle: nil), forCellWithReuseIdentifier: "EventImageCollectionViewCell")

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.collectionViewPetsWalks {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "EventImageCollectionViewCell", for: indexPath) as? EventImageCollectionViewCell {

                let url = "https://picsum.photos/id/\(indexPath.row + 1)/600/200"
                cell.setup(url: url, collectionViewName: "Walks")

                return cell
            }

        } else if collectionView == self.collectionViewPetsCompetitions {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "EventImageCollectionViewCell", for: indexPath) as? EventImageCollectionViewCell {

                let url = "https://picsum.photos/id/\(indexPath.row + 50)/300/300?grayscale"
                cell.setup(url: url, collectionViewName: "Competitions")
                return cell
            }
        } else if collectionView == self.collectionViewPetsTraining {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "EventImageCollectionViewCell", for: indexPath) as? EventImageCollectionViewCell {

                let url = "https://picsum.photos/id/\(indexPath.row + 100)/300/300?blur"
                cell.setup(url: url, collectionViewName: "Training")
                return cell
            }
        } else if collectionView == self.collectionViewPetsHealts {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "EventImageCollectionViewCell", for: indexPath) as? EventImageCollectionViewCell {

                let url = "https://picsum.photos/id/\(indexPath.row + 150)/200/400?grayscale&blur=2"
                cell.setup(url: url, collectionViewName: "Healts")
                return cell
            }
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == self.collectionViewPetsWalks {
            return 50
        } else if collectionView == self.collectionViewPetsCompetitions {
            return 100
        } else if collectionView == self.collectionViewPetsTraining {
            return 150
        } else if collectionView == self.collectionViewPetsHealts {
            return 200
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        if collectionView == self.collectionViewPetsWalks {
            let width = collectionView.bounds.width
            return CGSize(width: width, height: height)
        } else if  collectionView == self.collectionViewPetsCompetitions {
            let width = collectionView.bounds.width
            return CGSize(width: width, height: height)
        } else if  collectionView == self.collectionViewPetsTraining {
            let width = collectionView.bounds.width
            return CGSize(width: width, height: height)
        } else if  collectionView == self.collectionViewPetsHealts {
            let width = collectionView.bounds.width
            return CGSize(width: width, height: height)
        }
        return CGSize(width: 0, height: 0)
    }

}
