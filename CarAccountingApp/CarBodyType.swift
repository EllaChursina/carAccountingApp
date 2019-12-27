//
//  CarBodyType.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 25.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import Foundation

protocol EnumIterable: RawRepresentable, CaseIterable {
    var indexValue: Int { get }
}

extension EnumIterable where Self.RawValue: Equatable {
    var indexValue: Int {
        var index = -1
        let cases = Self.allCases as? [Self] ?? []
        for (caseIndex, caseItem) in cases.enumerated() {
            if caseItem.rawValue == self.rawValue {
                index = caseIndex
                break
            }
        }
        return index
    }
}

enum CarBodyType: String, CaseIterable, EnumIterable {
    case hatchback = "hatchback"
    case sedan = "sedan"
    case mvp = "mvp"
    case suv = "suv"
    case crossover = "crossover"
    case coupe = "coupe"
    case convertible = "convertible"
    
    static let intMap: Dictionary<Int, String> = [
        0: "hatchback",
        1: "sedan",
        2: "mvp",
        3: "suv",
        4: "crossover",
        5: "coupe",
        6: "convertible",
    ]
}
