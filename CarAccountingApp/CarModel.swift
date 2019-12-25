//
//  CarModel.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 18.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import Foundation
import UIKit

enum CarBodyType: String, CaseIterable {
    case hatchback = "hatchback"
    case sedan = "sedan"
    case mvp = "mvp"
    case suv = "suv"
    case crossover = "crossover"
    case coupe = "coupe"
    case convertible = "convertible"
}

struct Car {
    var yearOfIssue: Int
    var manufacturingCompany: String
    var model: String
    var bodyType: CarBodyType
}

class CarModel {
    var cars = [Car]()
    init() {
       getCars()
    }
    
    func deleteCar(indexPath: IndexPath){
        cars.remove(at: indexPath.row)
    }
    
    func getCars() {
        cars.append(Car(yearOfIssue: 2010, manufacturingCompany: "Renault", model: "Kwid", bodyType: .hatchback))
        cars.append(Car(yearOfIssue: 2015, manufacturingCompany: "Skoda", model: "Octavia", bodyType: .sedan))
        cars.append(Car(yearOfIssue: 2013, manufacturingCompany: "Maruti Suzuki", model: "Omni", bodyType: .mvp))
        cars.append(Car(yearOfIssue: 2008, manufacturingCompany: "Honda", model: "CR-V", bodyType: .suv))
        cars.append(Car(yearOfIssue: 2018, manufacturingCompany: "Volvo", model: "S60 Cross Country", bodyType: .crossover))
        cars.append(Car(yearOfIssue: 2010, manufacturingCompany: "Ford", model: "Mustang", bodyType: .coupe))
        cars.append(Car(yearOfIssue: 2017, manufacturingCompany: "Audi", model: "A3 Cabriolet", bodyType: .convertible))
        cars.append(Car(yearOfIssue: 2012, manufacturingCompany: "Hyundai", model: "Grand i10", bodyType: .hatchback))
        cars.append(Car(yearOfIssue: 2001, manufacturingCompany: "Hyundai", model: "Elantra", bodyType: .sedan))
        cars.append(Car(yearOfIssue: 2007, manufacturingCompany: "Maruti Suzuki", model: "Eeco", bodyType: .mvp))
        cars.append(Car(yearOfIssue: 2011, manufacturingCompany: "Skoda", model: "Yeti", bodyType: .suv))
        cars.append(Car(yearOfIssue: 2019, manufacturingCompany: "Maruti Suzuki", model: "S-Cross", bodyType: .crossover))
        cars.append(Car(yearOfIssue: 2005, manufacturingCompany: "Audi", model: "R8", bodyType: .coupe))
        cars.append(Car(yearOfIssue: 2017, manufacturingCompany: "Mercedes", model: "AMG SLC 43", bodyType: .convertible))
    }
    
    }
