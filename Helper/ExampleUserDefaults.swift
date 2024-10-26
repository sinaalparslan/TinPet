//
//  ExampleUserDefaults.swift
//  app
//
//  Created by Ali Sefa Alparslan on 13.12.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import Foundation

class ExampleUserDefaults {

    let userDefaults = UserDefaults.standard

    func addSingleObject() {
        let userDefaults = UserDefaults.standard

        let singleObject = ExampleUserDefaultsModel(age: 17, name: "Sina Alparslan", tckn: 123)
        userDefaults.setObject(singleObject, forKey: "Sina Alparslan")
    }

    func addListOfObject() {
        let sina = ExampleUserDefaultsModel(age: 17, name: "Sina Alparslan", tckn: 123)
        let sefa = ExampleUserDefaultsModel(age: 18, name: "Sefa Alparslan", tckn: 1234)
        let people = [sina, sefa]
        userDefaults.setObject(people, forKey: "people")
    }

    func getSingleObject() -> ExampleUserDefaultsModel? {
        let singleObject = userDefaults.getObject(forKey: "Sina Alparslan", castTo: ExampleUserDefaultsModel.self)
        return singleObject
    }

    func getListOfObject() {
        if let people = userDefaults.getObject(forKey: "people", castTo: [ExampleUserDefaultsModel].self) {
            for person in people where person.age > 15 {
                    print(people)
            }
        }
    }

    func updateSingleObject() {
        var singleObject = userDefaults.getObject(forKey: "Sina Alparslan", castTo: ExampleUserDefaultsModel.self)
        singleObject?.age += 1
        userDefaults.setObject(singleObject, forKey: "Sina Alparslan")
    }

    func updataListOfObject() {
        if let people = userDefaults.getObject(forKey: "people", castTo: [ExampleUserDefaultsModel].self) {
            var pppp = people
            pppp[0].tckn = 99999
            userDefaults.setObject(pppp, forKey: "people")
        }
    }

    func clearAllUserDefaults() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }

    func getAllUserDefaults() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            print(key)
        }
    }

    func setPrimaryType() {
        let value = "Bu denemedir"
        let key = "primaryStringTest"

        userDefaults.set(value, forKey: key)
    }

    func getPrimaryType() {

        let myString = userDefaults.string(forKey: "primaryStringTest")
        // or
        let myString2 = userDefaults.object(forKey: "primaryStringTest") as? String
    }

}

// Modeller Codable tipinde olmalı
struct ExampleUserDefaultsModel: Codable {
    var age: Int
    var name: String
    var tckn: Int
}
