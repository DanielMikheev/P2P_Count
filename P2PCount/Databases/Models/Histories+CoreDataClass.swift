//
//  Histories+CoreDataClass.swift
//  P2PCount
//
//  Created by Dany on 24.05.2025.
//
//

import Foundation
import CoreData

@objc(Histories)
public class Histories: NSManagedObject {

    
}

extension Histories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Histories> {
        return NSFetchRequest<Histories>(entityName: "Histories")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: String?
    @NSManaged public var buy: String?
    @NSManaged public var swap: String?
    @NSManaged public var sell: String?
    @NSManaged public var exchange: String?
    @NSManaged public var pair: String?
    @NSManaged public var price: String?
    @NSManaged public var comission: String?
    @NSManaged public var profitAndSpreadText: String?
    @NSManaged public var buyNameExchange: String?
    @NSManaged public var swapNameExchange: String?
    @NSManaged public var sellNameExchange: String?
    @NSManaged public var currencyPair: String?
    @NSManaged public var buyCurrencyPair: String?
    @NSManaged public var swapCurrencyPair: String?
    @NSManaged public var sellCurrencyPair: String?
    @NSManaged public var buyPrice: String?
    @NSManaged public var swapPrice: String?
    @NSManaged public var sellPrice: String?
    @NSManaged public var commision: String?
    @NSManaged public var buyCommision: String?
    @NSManaged public var swapCommision: String?
    @NSManaged public var sellCommision: String?
    @NSManaged public var profitAndSpreadResult: String?

}

extension Histories : Identifiable {

}
