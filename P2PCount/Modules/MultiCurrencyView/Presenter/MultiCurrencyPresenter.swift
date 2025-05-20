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
        NotificationCenter.default.post(name: .addCircle, object: nil, userInfo: [String.add : AddCircles.multi ])
    }
}
