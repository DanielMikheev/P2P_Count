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
    func countSpreadAndProfit()
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
            "swapPair": self.view?.swapCurrencyPair.text ?? "",
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
    
    func countSpreadAndProfit(){
        guard let bank = self.view?.bankTextField.text, !bank.isEmpty,
              let sellPriceText = self.view?.sellPrice.text, !sellPriceText.isEmpty,
              let swapPriceText = self.view?.swapPrice.text , !swapPriceText.isEmpty,
              let buyPriceText = self.view?.buyPrice.text, !buyPriceText.isEmpty,
              let sellCommision = self.view?.sellCommision.text, !sellCommision.isEmpty,
              let swapComission = self.view?.swapCommision.text, !swapComission.isEmpty,
              let buyCommision = self.view?.buyCommision.text, !buyCommision.isEmpty else { return }
        
        if let sell = Float(sellPriceText), let swap = Float(swapPriceText), let buy = Float(buyPriceText), let sellCom = Float(sellCommision), let swapCom = Float(swapComission), let buyCom = Float(buyCommision), let money = Float(bank){
            
            let buyWithComission: Float = money / buy * (1 - buyCom / 100)
            let swapWithComission: Float = buyWithComission / swap * (1 - swapCom / 100)
            let sellWithComission: Float = swapWithComission * sell * (1 - sellCom / 100)
            
            let moneyResult: Float = sellWithComission - money
            let spreadResult: Float = moneyResult / money
            
            let spreadResultStr = String(NSString(format: "%.2f", (spreadResult * 100)))
            let moneyResultStr = Int(moneyResult)
            
            self.view?.spreadPercentProfit.font =  UIFont(name: "K2D-Bold", size: 18)
            self.view?.moneyProfit.font = UIFont(name: "K2D-Bold", size: 18)
            self.view?.spreadPercentProfit.text = "\(spreadResultStr)"
            self.view?.moneyProfit.text = "\(moneyResultStr)"

            
        }else{
            print("Заполните все поля!")
        }
        
    }
}
