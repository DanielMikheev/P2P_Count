//
//  MultiCurrencyPresenter.swift
//  P2PCount
//
//  Created by Dany on 10.05.2025.
//

import UIKit
import Foundation

protocol MultiCurrencyPresenterProtocol: AnyObject {
    func addHistoryCircles()
}

class MultiCurrencyPresenter: MultiCurrencyPresenterProtocol{
    
    weak var view: MultiCurrencyViewControllerProtocol?
    
    init(view: MultiCurrencyViewControllerProtocol?) {
        self.view = view
    }
    
    func addHistoryCircles(){
        let userInfo: [String: Any] = [
            String.add: AddCircles.multi,
            "buyPair": self.view?.buyCurrencyPair.text ?? "",
            "swapPair": self.view?.swapPrice.text ?? "",
            "sellPair": self.view?.sellCurrencyPair.text ?? "",
            "buyPrice": self.view?.buyPrice.text ?? "",
            "swapPrice": self.view?.swapPrice.text ?? "",
            "sellPrice": self.view?.sellPrice.text ?? "",
            "buyComission": self.view?.buyCommision.text ?? "",
            "swapComission": self.view?.swapCommision.text ?? "",
            "sellComission": self.view?.sellCommision.text ?? "",
            "spreadPercentProfit": self.view?.spreadPercentProfit.text ?? "",
            "moneyProfit": self.view?.moneyProfit.text ?? ""
        ]
        
        NotificationCenter.default.post(name: .addCircle, object: nil, userInfo: userInfo)
        
    }
}
