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
    
    lazy var resetAction: UIAction = UIAction { [weak self ]_ in
        guard let self = self else { return }
        self.resetAll()
    }
    
    private func resetAll(){
        guard selectedIndex == 0 || selectedIndex == 1 else { return }
        
        if selectedIndex == 0{
                self.oneVC.bankTextField.text = ""
                self.oneVC.buyCurrencyPair.text = ""
                self.oneVC.buyPrice.text = ""
                self.oneVC.buyCommision.text = ""
                self.oneVC.sellCurrencyPair.text = ""
                self.oneVC.sellPrice.text = ""
                self.oneVC.sellCommision.text = ""
                self.oneVC.spreadPercentProfit.text = ""
                self.oneVC.moneyProfit.text = ""
                self.oneVC.bankTextField.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.buyCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.buyPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.buyCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.sellCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.sellPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.sellCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.spreadPercentProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.oneVC.moneyProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
            
            }else if selectedIndex == 1{
                self.multiVC.bankTextField.text = ""
                self.multiVC.buyCurrencyPair.text = ""
                self.multiVC.buyPrice.text = ""
                self.multiVC.buyCommision.text = ""
                self.multiVC.swapCurrencyPair.text = ""
                self.multiVC.swapPrice.text = ""
                self.multiVC.swapCommision.text = ""
                self.multiVC.sellCurrencyPair.text = ""
                self.multiVC.sellPrice.text = ""
                self.multiVC.sellCommision.text = ""
                self.multiVC.spreadPercentProfit.text = ""
                self.multiVC.moneyProfit.text = ""
                self.multiVC.bankTextField.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.buyCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.buyPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.buyCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.swapCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.swapPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.swapCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.sellCurrencyPair.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.sellPrice.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.sellCommision.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.spreadPercentProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
                self.multiVC.moneyProfit.font = UIFont(name: "K2D-ExtraLight", size: 14)
                
            }
        }
    }
