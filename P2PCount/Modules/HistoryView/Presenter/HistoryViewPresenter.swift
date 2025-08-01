//
//  HistoryViewPresenter.swift
//  P2PCount
//
//  Created by Dany on 11.05.2025.
//

import Foundation
import UIKit

protocol HistoryViewPresenterProtocol: AnyObject {
    func createHistoryItems()
    func addCirclesHistory(nt: Notification)
    var context: AddCircles? { get set }
    var allItems: [Histories] { get set }
    func deleteItem(_ cell: UICollectionViewCell)
    var dataManager: StorageManager { get set }
}

class HistoryViewPresenter: HistoryViewPresenterProtocol{
    
    //dataBase Manager
    var dataManager = StorageManager.shared
    
    //views
    weak var view: HistoryViewControllerProtocol?
    
    
    //data and context
    var allItems: [Histories] = []
    var context: AddCircles?
    
    init(view: HistoryViewControllerProtocol?, context: AddCircles? = nil) {
        self.view = view
        self.context = context
        createHistoryItems()
    }
    
    func deleteItem(_ cell: UICollectionViewCell) {
        guard let indexPath = self.view?.historyCollectionView.indexPath(for: cell) else { return }
        self.allItems.remove(at: indexPath.item)
        
        if self.allItems.isEmpty {
            let label = UILabel()
            label.text = "No data"
            label.font = UIFont(name: "K2D-Bold", size: 20)
            label.textAlignment = .center
            label.textColor = .content
            self.view?.historyCollectionView.backgroundView = label
            self.view?.historyCollectionView.reloadData()
        } else {
            self.view?.historyCollectionView.performBatchUpdates({
                self.view?.historyCollectionView.deleteItems(at: [indexPath])
            }, completion: {_ in 
                self.view?.historyCollectionView.collectionViewLayout.invalidateLayout()
            })
            
        }
    }
    
    private func setupCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }

    func createHistoryItems(){
        NotificationCenter.default.addObserver(self, selector: #selector(addCirclesHistory(nt: )), name: .addCircle, object: nil)
    }
    
    @objc func addCirclesHistory(nt: Notification){
        guard let userInfo = nt.userInfo else { return }
        
        DispatchQueue.main.async{
            self.view?.historyCollectionView.backgroundView = nil
            if let info = userInfo[String.add] as? AddCircles{
                switch info{
                case .one:
                    let oneDate = self.setupCurrentDate()
                    
                    guard let buyPair = userInfo["buyPair"] as? String,
                          let sellPair = userInfo["sellPair"] as? String,
                          let buyPrice = userInfo["buyPrice"] as? String,
                          let sellPrice = userInfo["sellPrice"] as? String,
                          let buyComission = userInfo["buyComission"] as? String,
                          let sellComission = userInfo["sellComission"] as? String,
                          let spreadPercentProfit = userInfo["spreadPercentProfit"] as? String,
                          let moneyProfit = userInfo["moneyProfit"] as? String else { return }
                    
                    let oneNewData = HistoryItem(date: "Date: \(oneDate)",
                                                 buy: "Buy",
                                                 sell: "Sell",
                                                 buyNameExchange: "Bybit",
                                                 sellNameExchange: "OKX",
                                                 buyCurrencyPair: "\(buyPair)",
                                                 sellCurrencyPair: "\(sellPair)",
                                                 buyPrice: "\(buyPrice)",
                                                 sellPrice: "\(sellPrice)",
                                                 buyCommision: "\(buyComission)",
                                                 sellCommision: "\(sellComission)",
                                                 profitAndSpreadResult: "\(moneyProfit) $ / \(spreadPercentProfit) %")
                    self.dataManager.createHistory(historyData: oneNewData)
                    self.dataManager.saveContext()
                    
                    guard let savedItem = self.dataManager.historiesData.last else { return }
                    self.allItems.append(savedItem)
                    
                    self.dataManager.getAllHistories()
                    self.allItems = self.dataManager.historiesData
                    
                    let oneNewIndexPath = IndexPath(item: self.allItems.count - 1, section: 0)
                    
                    self.view?.historyCollectionView.performBatchUpdates({
                        self.view?.historyCollectionView.insertItems(at: [oneNewIndexPath])
                    }, completion: { _ in
                        self.view?.historyCollectionView.scrollToItem(at: oneNewIndexPath, at: .centeredVertically, animated: true)
                    })
                    
                    self.context = .one
                    
                case .multi:
                    let multiDate = self.setupCurrentDate()
                    
                    guard let buyPair = userInfo["buyPair"] as? String,
                          let swapPair = userInfo["swapPair"] as? String,
                          let sellPair = userInfo["sellPair"] as? String,
                          let buyPrice = userInfo["buyPrice"] as? String,
                          let swapPrice = userInfo["swapPrice"] as? String,
                          let sellPrice = userInfo["sellPrice"] as? String,
                          let buyComission = userInfo["buyComission"] as? String,
                          let swapComission = userInfo["swapComission"] as? String,
                          let sellComission = userInfo["sellComission"] as? String,
                          let spreadPercentProfit = userInfo["spreadPercentProfit"] as? String,
                          let moneyProfit = userInfo["moneyProfit"] as? String else { return }
                    
                    let multiNewData = HistoryItem(date: "Date: \(multiDate)",
                                                   buy: "Buy",
                                                   swap: "Swap",
                                                   sell: "Sell",
                                                   buyNameExchange: "Binance",
                                                   swapNameExchange: "OKX",
                                                   sellNameExchange: "Arkham",
                                                   buyCurrencyPair: "\(buyPair)",
                                                   swapCurrencyPair: "\(swapPair)",
                                                   sellCurrencyPair: "\(sellPair)",
                                                   buyPrice: "\(buyPrice)",
                                                   swapPrice: "\(swapPrice)",
                                                   sellPrice: "\(sellPrice)",
                                                   buyCommision: "\(buyComission)",
                                                   swapCommision: "\(swapComission)",
                                                   sellCommision: "\(sellComission)",
                                                   profitAndSpreadResult: "\(moneyProfit) $ / \(spreadPercentProfit) %")
                    
                    self.dataManager.createHistory(historyData: multiNewData)
                    self.dataManager.saveContext()
                    
                    guard let savedItem = self.dataManager.historiesData.last else { return }
                    self.allItems.append(savedItem)
                    
                    self.dataManager.getAllHistories()
                    self.allItems = self.dataManager.historiesData
                    
                    let multiNewIndexPath = IndexPath(item: self.allItems.count - 1, section: 0)
                    
                    self.view?.historyCollectionView.performBatchUpdates({
                        self.view?.historyCollectionView.insertItems(at: [multiNewIndexPath])
                    }, completion: { _ in
                        self.view?.historyCollectionView.scrollToItem(at: multiNewIndexPath, at: .centeredVertically, animated: true)
                    })
                    self.context = .multi
                }
            }
        }
    }
}
