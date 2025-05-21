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
    
    var allItems: [HistoryItem] = []
    var context: AddCircles?
    
    weak var view: HistoryViewControllerProtocol?
    
    init(view: HistoryViewControllerProtocol?, context: AddCircles? = nil) {
        self.view = view
        self.context = context
        createHistoryItems()
    }
//    private func updateCell(at index: Int, with newText: String) {
//        guard index < self.historySection[0].items.count else { return }
//        
//        self.historySection[0].items[index].date = newText
//        let indexPath = IndexPath(item: index, section: 0)
//        self.view?.historyCollectionView.reloadItems(at: [indexPath])
//    }

    func createHistoryItems(){
        NotificationCenter.default.addObserver(self, selector: #selector(addCirclesHistory(nt: )), name: .addCircle, object: nil)
    }
    
    @objc func addCirclesHistory(nt: Notification){
        guard let userInfo = nt.userInfo else { return }
        if let info = userInfo[String.add] as? AddCircles{
            switch info{
            case .one:
                let oneNewData = HistoryItem(buyPrice: "100.25", buyCommision: "0.91")
                let oneNewIndexPath = IndexPath(item: allItems.count, section: 0)
                allItems.append(oneNewData)
                self.view?.historyCollectionView.insertItems(at: [oneNewIndexPath])
                self.view?.historyCollectionView.scrollToItem(at: oneNewIndexPath, at: .centeredVertically, animated: true)
                self.context = .one
            case .multi:
                let multiNewData = HistoryItem(buyPrice: "93.25", buyCommision: "0.1")
                let multiNewIndexPath = IndexPath(item: allItems.count, section: 0)
                allItems.append(multiNewData)
                self.view?.historyCollectionView.insertItems(at: [multiNewIndexPath])
                self.view?.historyCollectionView.scrollToItem(at: multiNewIndexPath, at: .centeredVertically, animated: true)
                self.context = .multi
            }
        }
    }
}
