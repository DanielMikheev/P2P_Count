//
//  OneCurrencyPresenter.swift
//  P2PCount
//
//  Created by Dany on 03.05.2025.
//

import UIKit
import Foundation

protocol OneCurrencyPresenterProtocol: AnyObject {
    func countSpreadAndProfit()
    func resetAllFields()
    func addHistoryCircles()
}

final class OneCurrencyPresenter: OneCurrencyPresenterProtocol {
    
    weak var view: OneCurrencyViewControllerProtocol?
    
    init(view: OneCurrencyViewControllerProtocol?) {
        self.view = view
    }
    
    func addHistoryCircles(){
        
        let userInfo: [String: Any] = [
            String.add: AddCircles.one,
            "buyPair": self.view?.buyCurrencyPair.text ?? "",
            "sellPair": self.view?.sellCurrencyPair.text ?? "",
            "buyPrice": self.view?.buyPrice.text ?? "",
            "sellPrice": self.view?.sellPrice.text ?? "",
            "buyComission": self.view?.buyCommision.text ?? "",
            "sellComission": self.view?.sellCommision.text ?? "",
            "spreadPercentProfit": self.view?.spreadPercentProfit.text ?? "",
            "moneyProfit": self.view?.moneyProfit.text ?? ""
        ]
        
        NotificationCenter.default.post(name: .addCircle, object: nil, userInfo: userInfo)

    }
    
    
    
    func countSpreadAndProfit(){
        guard let bank = self.view?.bankTextField.text, !bank.isEmpty,
              let sellPriceText = self.view?.sellPrice.text, !sellPriceText.isEmpty,
              let buyPriceText = self.view?.buyPrice.text, !buyPriceText.isEmpty,
              let sellCommision = self.view?.sellCommision.text, !sellCommision.isEmpty,
              let buyCommision = self.view?.buyCommision.text, !buyCommision.isEmpty else { return }
        
        if let sell = Float(sellPriceText), let buy = Float(buyPriceText), let sellCom = Float(sellCommision), let buyCom = Float(buyCommision), let money = Float(bank){
            
            let spreadPercent: Float = ((sell * (1 - sellCom))/(buy * (1 - buyCom)) - 1)
            let spreadPercentNew = String(format: "%.2f", (spreadPercent * 100))
            let moneyProfit: Int = Int(money * (spreadPercent))
            
            self.view?.spreadPercentProfit.font = UIFont(name: "K2D-Bold", size: 18)
            self.view?.moneyProfit.font = UIFont(name: "K2D-Bold", size: 18)
            self.view?.spreadPercentProfit.text = "\(spreadPercentNew)"
            self.view?.moneyProfit.text = "\(moneyProfit)"

            
        }else{
            print("Заполните все поля!")
        }
        
    }
    
    func resetAllFields(){
        self.view?.bankTextField.text? = ""
        self.view?.sellCurrencyPair.text? = ""
        self.view?.buyCurrencyPair.text? = ""
        self.view?.sellPrice.text? = ""
        self.view?.buyPrice.text? = ""
        self.view?.sellCommision.text? = ""
        self.view?.buyCommision.text? = ""
    }
}
