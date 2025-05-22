//
//  MainTabBarController.swift
//  P2PCount
//
//  Created by Dany on 08.05.2025.
//

import UIKit

protocol MainTabBarControllerProtocol: AnyObject {
    
}
class MainTabBarController: UITabBarController, MainTabBarControllerProtocol {
    
    var presenter: MainTabBarPresenterProtocol!

    //controllers
    private let oneVC = Builder.createOneCurrencyView() as! OneCurrencyViewController
    private let multiVC = Builder.createMultiCurrencyView() as! MultiCurrencyViewController
    private let historyVC = Builder.createHistoryView() as! HistoryViewController
    private let resetVC = ResetViewController()
    
    //buttons
    private lazy var oneBtn: UIButton = setButton(icon: "ic-one", tag: 0, action: action)
    private lazy var multiBtn: UIButton = setButton(icon: "ic-multi", tag: 1, action: action)
    private lazy var historyBtn: UIButton = setButton(icon: "ic-history", tag: 2, action: action)
    private lazy var resetBtn: UIButton = setResetButton(icon: "ic-reset", action: resetAction)

     
    private lazy var tabStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = .lightMain
        $0.frame = CGRect(x: 20, y: view.frame.height - 120, width: view.frame.width - 40, height: 70)
        $0.layer.cornerRadius = 25
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(oneBtn)
        $0.addArrangedSubview(multiBtn)
        $0.addArrangedSubview(historyBtn)
        $0.addArrangedSubview(resetBtn)
        $0.addArrangedSubview(UIView())
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabStack)
        tabBar.isHidden = true
        setViewControllers([oneVC, multiVC, historyVC, resetVC], animated: true)
    }


    private func setButton(icon: String, tag: Int, action: UIAction?) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.setImage(UIImage(named: icon), for: .normal)
        btn.tintColor = .text
        btn.tag = tag
        return btn
    }
    
    private func setResetButton(icon: String, action: UIAction?) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.setImage(UIImage(named: icon), for: .normal)
        btn.tintColor = .text
        return btn
    }
    
    private func setOpacity(tag: Int){
        [oneBtn, multiBtn, historyBtn].forEach { btn in
            if btn.tag != tag {
                btn.tintColor = .text
            }else {
                btn.tintColor = .accent
            }
        }
    }
    
    lazy var action: UIAction = UIAction { [weak self] sender in
        guard let self = self else { return }
        guard let sender = sender.sender as? UIButton else { return }
        self.selectedIndex = sender.tag
        self.setOpacity(tag: sender.tag)
        
    }
    
    lazy var resetAction: UIAction = UIAction{ [weak self] sender in
        guard let self = self else { return }
        guard let sender = sender.sender as? UIButton else { return }
        self.selectedIndex = sender.tag
        
        if sender.tag == 0{
            oneVC.bankTextField.text = ""
            oneVC.buyCurrencyPair.text = ""
            oneVC.buyPrice.text = ""
            oneVC.buyCommision.text = ""
            oneVC.sellCurrencyPair.text = ""
            oneVC.sellPrice.text = ""
            oneVC.sellCommision.text = ""
            oneVC.spreadPercentProfit.text = ""
            oneVC.moneyProfit.text = ""
            
            oneVC.bankTextField.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.buyCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.buyPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.buyCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.sellCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.sellPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.sellCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.spreadPercentProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
            oneVC.moneyProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
        } else if sender.tag == 1{
            
            multiVC.bankTextField.text = ""
            multiVC.buyCurrencyPair.text = ""
            multiVC.buyPrice.text = ""
            multiVC.buyCommision.text = ""
            multiVC.sellCurrencyPair.text = ""
            multiVC.sellPrice.text = ""
            multiVC.sellCommision.text = ""
            multiVC.spreadPercentProfit.text = ""
            multiVC.moneyProfit.text = ""
            
            multiVC.bankTextField.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.buyCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.buyPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.buyCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.sellCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.sellPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.sellCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.spreadPercentProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
            multiVC.moneyProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
        }
        
    }
    
}
