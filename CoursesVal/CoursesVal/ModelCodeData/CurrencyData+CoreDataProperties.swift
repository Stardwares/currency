//
//  CurrencyData+CoreDataProperties.swift
//  CoursesVal
//
//  Created by Вадим Пустовойтов on 23.09.2018.
//  Copyright © 2018 Вадим Пустовойтов. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyData> {
        return NSFetchRequest<CurrencyData>(entityName: "CurrencyData")
    }

    @NSManaged public var charCode: String?
    @NSManaged public var name: String?
    @NSManaged public var nominal: String?
    @NSManaged public var nominalDouble: Double
    @NSManaged public var numCode: String?
    @NSManaged public var value: String?
    @NSManaged public var valueDouble: Double

}
