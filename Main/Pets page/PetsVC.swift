//
//  PetsVC.swift
//  app
//
//  Created by sina on 13.12.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import UIKit

class PetsVC: UIViewController {

    @IBOutlet weak var buttonAddPet: UIButton!

    @IBOutlet weak var tableViewMyPetsList: UITableView!
    let userDefaults = UserDefaults.standard
    var animalList: [AnimalModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMyPetsList.dataSource = self
        tableViewMyPetsList.delegate = self

        animalList = userDefaults.getObject(forKey: "animalList", castTo: [AnimalModel].self) ?? []
        tableViewMyPetsList.register(UINib(nibName: "PetsTableViewCell", bundle: nil), forCellReuseIdentifier: "PetsTableViewCell")
        tableViewMyPetsList.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animalList = userDefaults.getObject(forKey: "animalList", castTo: [AnimalModel].self) ?? []
        tableViewMyPetsList.reloadData()
    }
    @IBAction func actionAddPet(_ sender: Any) {
        let viewController = CreatePetsVC()
        viewController.isModalInPresentation = true
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PetsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let viewController = CreatePetsVC()
        let animals = userDefaults.getObject(forKey: "animalList", castTo: [AnimalModel].self)
        viewController.setData(animal: animals?[indexPath.row])
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)

    }
    func clearUserDefaults(for pet: AnimalModel) {
        let key = "animalList"
        if var savedAnimalList = userDefaults.getObject(forKey: key, castTo: [AnimalModel].self) {
            if let index = savedAnimalList.firstIndex(where: { $0.name == pet.name }) {
                savedAnimalList.remove(at: index)
                userDefaults.setObject(savedAnimalList, forKey: key)
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedata = self.animalList[indexPath.row]
            self.animalList.remove(at: indexPath.row)
            self.clearUserDefaults(for: removedata)
            self.tableViewMyPetsList.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PetsTableViewCell", for: indexPath) as? PetsTableViewCell {
            if let petName = animalList[indexPath.row].name {
                cell.setup(petname: petName)
            }
            return cell
        }
        return UITableViewCell()
    }
}
