//
//  HistoryViewPresenter.swift
//  P2PCount
//
//  Created by Dany on 11.05.2025.
//

import Foundation
import UIKit

protocol HistoryViewPresenterProtocol: AnyObject {
    var historySection: [HistorySection] { get set }
    func createHistoryItems()
    func addCirclesHistory(nt: Notification)
    var context: AddCircles? { get set }

}

class HistoryViewPresenter: HistoryViewPresenterProtocol{
    
    
    var historySection = HistorySection.historyData()
    var historyItem = HistoryItem()
    var context: AddCircles?
    
    weak var view: HistoryViewControllerProtocol?
    
    init(view: HistoryViewControllerProtocol?, context: AddCircles? = nil) {
        self.view = view
        self.context = context
        createHistoryItems()
    }
   

    func createHistoryItems(){
        NotificationCenter.default.addObserver(self, selector: #selector(addCirclesHistory(nt: )), name: .addCircle, object: nil)
    }
    
    @objc func addCirclesHistory(nt: Notification){
        guard let userInfo = nt.userInfo else { return }
        if let info = userInfo[String.add] as? AddCircles{
            switch info{
            case .one:
                historySection[0].items.append(historyItem)
                self.view?.historyCollectionView.reloadData()
                self.context = .one
            case .multi:
                historySection[0].items.append(historyItem)
                self.view?.historyCollectionView.reloadData()
                self.context = .multi
            }
        }
    }
}
