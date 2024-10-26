//
//  PetsHomeViewController.swift
//  app
//
//  Created by Ali Sefa Alparslan on 4.12.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import UIKit

class PetsHomeVC: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!

    var selectedPage: UIViewController?
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = selectedIndex
        navigationItem.titleView = segmentedControl
        navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 200, height: 30)

        updateUI()

    }

    func getAnimalList() -> [AnimalModel] {
        // swiftlint:disable line_length

        return [
            AnimalModel(type: "Cat", kind: "Persian", birthDate: "2020-04-15", name: "Whiskers", vaccine: ["FVRCP", "Rabies"], illness: ["None"], photos: ["https://picsum.photos/id/1/600/200"], coverLater: "Spayed", location: ["longitude": 32.9212, "latitude": 39.8452], genre: "Male"),
            AnimalModel(type: "Dog", kind: "Golden Retriever", birthDate: "2019-08-22", name: "Buddy", vaccine: ["DHPP", "Rabies"], illness: ["Flea Infestation"], photos: ["dog1_photo1.jpg", "dog1_photo2.jpg"], coverLater: "Neutered", location: ["longitude": 35.8026, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Siamese", birthDate: "2022-01-10", name: "Mittens", vaccine: ["FVRCP"], illness: ["Upper Respiratory Infection"], photos: ["cat2_photo1.jpg", "cat2_photo2.jpg"], coverLater: "Not applicable", location: ["longitude": 35.8386, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Dog", kind: "Labrador Retriever", birthDate: "2021-05-03", name: "Max", vaccine: ["DHPP", "Rabies"], illness: ["Joint Pain"], photos: ["dog2_photo1.jpg", "dog2_photo2.jpg"], coverLater: "Neutered", location: ["longitude": 35.8016, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Maine Coon", birthDate: "2019-12-08", name: "Luna", vaccine: ["FVRCP", "Rabies"], illness: ["None"], photos: ["cat3_photo1.jpg", "cat3_photo2.jpg"], coverLater: "Spayed", location: ["longitude": 35.2086, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Dog", kind: "Poodle", birthDate: "2020-10-20", name: "Charlie", vaccine: ["DHPP"], illness: ["Allergies"], photos: ["dog3_photo1.jpg", "dog3_photo2.jpg"], coverLater: "Neutered", location: ["longitude": 35.816, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Persian", birthDate: "2021-01-15", name: "Whiskers", vaccine: ["Rabies", "Feline Distemper"], illness: ["None"], photos: ["cat1.jpg"], coverLater: "Blanket", location: ["longitude": 35.8016, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Cat", kind: "Siamese", birthDate: "2020-05-22", name: "Mittens", vaccine: ["Feline Leukemia"], illness: ["Cough"], photos: ["cat2.jpg"], coverLater: "Pillow", location: ["longitude": 31.8086, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Maine Coon", birthDate: "2019-11-10", name: "Shadow", vaccine: ["Rabies", "Feline Distemper"], illness: ["None"], photos: ["cat3.jpg"], coverLater: "Blanket", location: ["longitude": 32.8086, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Cat", kind: "Tabby", birthDate: "2022-02-28", name: "Oliver", vaccine: ["Rabies"], illness: ["None"], photos: ["cat4.jpg"], coverLater: "Basket", location: ["longitude": 33.8086, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Bengal", birthDate: "2020-08-12", name: "Leo", vaccine: ["Feline Leukemia"], illness: ["None"], photos: ["cat5.jpg"], coverLater: "Rug", location: ["longitude": 34.8086, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Dog", kind: "Labrador Retriever", birthDate: "2019-04-05", name: "Max", vaccine: ["Canine Distemper", "Kennel Cough"], illness: ["Arthritis"], photos: ["dog1.jpg"], coverLater: "Blanket", location: ["longitude": 35.8086, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Dog", kind: "German Shepherd", birthDate: "2020-10-18", name: "Bella", vaccine: ["Rabies"], illness: ["None"], photos: ["dog2.jpg"], coverLater: "Cushion", location: ["longitude": 36.8086, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Dog", kind: "Golden Retriever", birthDate: "2018-07-30", name: "Charlie", vaccine: ["Canine Distemper"], illness: ["None"], photos: ["dog3.jpg"], coverLater: "Bed", location: ["longitude": 37.8086, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Dog", kind: "Dachshund", birthDate: "2021-06-14", name: "Lola", vaccine: ["Parvovirus"], illness: ["None"], photos: ["dog4.jpg"], coverLater: "Sofa", location: ["longitude": 38.8086, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Dog", kind: "French Bulldog", birthDate: "2022-03-25", name: "Rocky", vaccine: ["Rabies", "Kennel Cough"], illness: ["Allergies"], photos: ["dog5.jpg"], coverLater: "Pillow", location: ["longitude": 39.8086, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Ragdoll", birthDate: "2020-09-08", name: "Misty", vaccine: ["Feline Leukemia"], illness: ["None"], photos: ["cat6.jpg"], coverLater: "Cushion", location: ["longitude": 21.8086, "latitude": 39.9334], genre: "Female"),
            AnimalModel(type: "Cat", kind: "Sphynx", birthDate: "2021-03-12", name: "Oreo", vaccine: ["Rabies", "Feline Distemper"], illness: ["None"], photos: ["cat7.jpg"], coverLater: "Blanket", location: ["longitude": 35.8086, "latitude": 39.1234], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Scottish Fold", birthDate: "2019-12-25", name: "Whiskey", vaccine: ["Rabies"], illness: ["None"], photos: ["cat8.jpg"], coverLater: "Basket", location: ["longitude": 35.8086, "latitude": 39.134], genre: "Male"),
            AnimalModel(type: "Cat", kind: "Birman", birthDate: "2022-01-30", name: "Luna", vaccine: ["Feline Distemper"], illness: ["None"], photos: ["cat9.jpg"], coverLater: "Sofa", location: ["longitude": 35.8086, "latitude": 39.4234], genre: "Female"),
            AnimalModel(type: "Cat", kind: "Russian Blue", birthDate: "2020-05-05", name: "Simba", vaccine: ["Rabies", "Feline Leukemia"], illness: ["None"], photos: ["cat10.jpg"], coverLater: "Blanket", location: ["longitude": 55.586, "latitude": 39.9334], genre: "Male"),
            AnimalModel(type: "Dog", kind: "Beagle", birthDate: "2018-11-14", name: "Coco", vaccine: ["Canine Distemper", "Parvovirus"], illness: ["None"], photos: ["dog6.jpg"], coverLater: "Rug", location: ["longitude": 35.8086, "latitude": 23.9334], genre: "Female"),
            AnimalModel(type: "Dog", kind: "Boxer", birthDate: "2019-07-22", name: "Rocko", vaccine: ["Rabies", "Kennel Cough"], illness: ["None"], photos: ["dog7.jpg"], coverLater: "Pillow", location: ["longitude": 35.8086, "latitude": 44.9334], genre: "Male"),
            AnimalModel(type: "Dog", kind: "Poodle", birthDate: "2021-04-02", name: "Princess", vaccine: ["Canine Distemper"], illness: ["Arthritis"], photos: ["dog8.jpg"], coverLater: "Blanket", location: ["longitude": 35.8086, "latitude": 55.9334], genre: "Female"),
            AnimalModel(type: "Dog", kind: "Shih Tzu", birthDate: "2020-08-28", name: "Teddy", vaccine: ["Rabies"], illness: ["None"], photos: ["dog9.jpg"], coverLater: "Cushion", location: ["longitude": 35.8086, "latitude": 34.9334], genre: "Male"),
            AnimalModel(type: "Dog", kind: "Siberian Husky", birthDate: "2022-02-10", name: "Loki", vaccine: ["Rabies", "Canine Distemper"], illness: ["None"], photos: ["dog10.jpg"], coverLater: "Sofa", location: ["longitude": 23.8086, "latitude": 52.9334], genre: "Male")
        ]

        // swiftlint:enable line_length
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if selectedIndex == 0 {
            selectedPage = PetsListVC()
            (selectedPage as? PetsListVC)?.animalList = getAnimalList()
            selectedPage?.navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.backward.circle"),
                style: .plain, target: self, action: #selector(actionBackPetsList(_:)))
            selectedPage?.navigationItem.titleView = segmentedControl
            selectedPage?.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
            selectedPage?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(selectedPage!, animated: false)
        } else if selectedIndex == 1 {
            selectedPage = PetsMapVC()
            (selectedPage as? PetsMapVC)?.animalList = getAnimalList()
            selectedPage?.navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.backward.circle"),
                style: .plain, target: self, action: #selector(actionBackPetsList(_:)))
            selectedPage?.navigationItem.titleView = segmentedControl
            selectedPage?.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
            selectedPage?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(selectedPage!, animated: false)
        }
    }

    @objc func actionBackPetsList(_ sender: UIButton) {

        selectedPage?.navigationController?.popViewController(animated: false)
        navigationController?.popViewController(animated: false)
    }

    func updateUI() {

        let background = UIColor.systemBackground.image(segmentedControl.frame.size)
        let selected = AppColor.Theme.image(segmentedControl.frame.size)

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.Theme], for: .normal)
        segmentedControl.setBackgroundImage(background, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(selected, for: .selected, barMetrics: .default)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = AppColor.Theme.cgColor
    }

    @IBAction func actionSegmentChange(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        selectedPage?.navigationController?.popViewController(animated: false)
    }

}
