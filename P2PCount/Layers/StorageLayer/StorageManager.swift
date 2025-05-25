//
//  StorageManager.swift
//  P2PCount
//
//  Created by Dany on 24.05.2025.
//

import CoreData

class StorageManager{
    
    static let shared = StorageManager()
    private init(){}
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HistoriesDataBase")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext(){
        let context = persistantContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var historiesData: [Histories] = []
    
    //crud
    
    func createHistory(historyData: HistoryItem){
        let history = Histories(context: persistantContainer.viewContext)
        history.id = historyData.id
        history.date = historyData.date
        history.buy = historyData.buy
        history.swap = historyData.swap
        history.sell = historyData.sell
        history.exchange = historyData.exchange
        history.pair = historyData.pair
        history.price = historyData.price
        history.comission = historyData.comission
        history.commision = historyData.commision
        history.profitAndSpreadText = historyData.profitAndSpreadText
        history.buyNameExchange = historyData.buyNameExchange
        history.swapNameExchange = historyData.swapNameExchange
        history.sellNameExchange = historyData.sellNameExchange
        history.currencyPair = historyData.currencyPair
        history.buyCurrencyPair = historyData.buyCurrencyPair
        history.swapCurrencyPair = historyData.swapCurrencyPair
        history.sellCurrencyPair = historyData.sellCurrencyPair
        history.buyPrice = historyData.buyPrice
        history.swapPrice = historyData.swapPrice
        history.sellPrice = historyData.sellPrice
        history.buyCommision = historyData.buyCommision
        history.swapCommision = historyData.swapCommision
        history.sellCommision = historyData.sellCommision
        history.profitAndSpreadResult = historyData.profitAndSpreadResult
        
        saveContext()
        getAllHistories()
    }
    
    func getAllHistories(){
        let request: NSFetchRequest<Histories> = Histories.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            historiesData = try persistantContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching histories: \(error)")
            historiesData = []
        }
        
    }
    
    func deleteHistory(history: Histories){
        persistantContainer.viewContext.delete(history)
        saveContext()
    }

    
    
}
