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
    var allItems: [HistoryItem] { get set }

}

class HistoryViewPresenter: HistoryViewPresenterProtocol{
    
    //views
    weak var view: HistoryViewControllerProtocol?
    var oneView = OneCurrencyViewController()
    weak var multiView: MultiCurrencyViewControllerProtocol?
    
    //data and context
    var allItems: [HistoryItem] = []
    var context: AddCircles?
 
    init(view: HistoryViewControllerProtocol?, context: AddCircles? = nil) {
        self.view = view
        self.context = context
        createHistoryItems()
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
        if let info = userInfo[String.add] as? AddCircles{
            switch info{
            case .one:
                let oneDate = setupCurrentDate()
                
                // Получаем данные из userInfo
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
                                            buyCurrencyPair: "\(buyPair)",
                                            sellCurrencyPair: "\(sellPair)",
                                            buyPrice: "\(buyPrice)",
                                            sellPrice: "\(sellPrice)",
                                            buyCommision: "\(buyComission)",
                                            sellCommision: "\(sellComission)",
                                            profitAndSpreadResult: "\(moneyProfit) $ / \(spreadPercentProfit) %")
                
                let oneNewIndexPath = IndexPath(item: allItems.count, section: 0)
                allItems.append(oneNewData)
                self.view?.historyCollectionView.insertItems(at: [oneNewIndexPath])
                self.view?.historyCollectionView.scrollToItem(at: oneNewIndexPath, at: .centeredVertically, animated: true)
                self.context = .one
            case .multi:
                let multiDate = setupCurrentDate()
                let multiNewData = HistoryItem(date: "Date: \(multiDate)",buyPrice: "93.25", buyCommision: "0.1")
                let multiNewIndexPath = IndexPath(item: allItems.count, section: 0)
                allItems.append(multiNewData)
                self.view?.historyCollectionView.insertItems(at: [multiNewIndexPath])
                self.view?.historyCollectionView.scrollToItem(at: multiNewIndexPath, at: .centeredVertically, animated: true)
                self.context = .multi
            }
        }
    }
}
