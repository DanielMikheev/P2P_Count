//
//  MultiCurrencyViewController.swift
//  P2PCount
//
//  Created by Dany on 08.05.2025.
//

import UIKit

protocol MultiCurrencyViewControllerProtocol: AnyObject {
    var bankTextField: UITextField { get set }
    var buyCurrencyPair: UITextField { get set }
    var buyPrice: UITextField { get set }
    var buyCommision: UITextField { get set }
    var swapCurrencyPair: UITextField { get set }
    var swapPrice: UITextField { get set }
    var swapCommision: UITextField { get set }
    var sellCurrencyPair: UITextField { get set }
    var sellPrice: UITextField { get set }
    var sellCommision: UITextField { get set }
    var spreadPercentProfit: UITextField { get set }
    var moneyProfit: UITextField { get set }
}
class MultiCurrencyViewController: UIViewController, MultiCurrencyViewControllerProtocol {
    
    var presenter: MultiCurrencyPresenterProtocol!
    
    private lazy var highFigure: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.frame.size = CGSize(width: view.frame.width, height: 136)
        $0.frame.origin = CGPoint(x: 0, y: 0)
        $0.backgroundColor = .lightMain
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return $0
    }(UIView())
    
    private lazy var menuButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "ic-menu"), for: .normal)
        return $0
    }(UIButton())
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Multi Currency"
        $0.font = UIFont(name: "K2D-Medium", size: 20)
        $0.textColor = .text
        $0.numberOfLines = 1
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var addCircleHistoryPlusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "ic-plus"), for: .normal)
        $0.tintColor = .text
        return $0
    }(UIButton(primaryAction: addCircles))
    
    lazy var addCircles: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.presenter.addHistoryCircles()
    }
    
    lazy var bankTextField: UITextField = {
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedPlaceholder = NSAttributedString(string: OneCurrencyTextModel.bank, attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1), .font: UIFont(name: "K2D-ExtraLight", size: 14) ?? ""])
        $0.placeholder = OneCurrencyTextModel.bank
        $0.backgroundColor = .lightMain
        $0.textColor = .accent
        $0.keyboardType = .numbersAndPunctuation
        $0.textAlignment = .center
        $0.returnKeyType = .done
        $0.keyboardAppearance = .dark
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        return $0
    }(UITextField())
    
    private lazy var bankImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "ic-dollar")
        return $0
    }(UIImageView())
    
    private lazy var buyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = OneCurrencyTextModel.buy
        $0.numberOfLines = 1
        $0.font = UIFont(name: "K2D-Light", size: 14)
        $0.textAlignment = .center
        $0.textColor = .content
        return $0
    }(UILabel())
    
    private lazy var swapLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = MultiCurrencyTextModel.swap
        $0.numberOfLines = 1
        $0.font = UIFont(name: "K2D-Light", size: 14)
        $0.textAlignment = .center
        $0.textColor = .content
        return $0
    }(UILabel())
    
    private lazy var sellLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = OneCurrencyTextModel.sell
        $0.numberOfLines = 1
        $0.font = UIFont(name: "K2D-Light", size: 14)
        $0.textAlignment = .center
        $0.textColor = .content
        return $0
    }(UILabel())
    
    //buy fields
    lazy var buyCurrencyPair: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.buyCurrencyPair, isEnabled: true, autocapitalize: .allCharacters)
    lazy var buyPrice: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.buyPrice, isEnabled: true, autocapitalize: .none)
    lazy var buyCommision: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.buyCommision, isEnabled: true, autocapitalize: .none)
    
    //swap fields
    lazy var swapCurrencyPair: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.swapCurrencyPair, isEnabled: true, autocapitalize: .allCharacters)
    lazy var swapPrice: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.swapPrice, isEnabled: true, autocapitalize: .none)
    lazy var swapCommision: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.swapCommision, isEnabled: true, autocapitalize: .none)
    
    //sell fields
    lazy var sellCurrencyPair: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.sellCurrencyPair, isEnabled: true, autocapitalize: .allCharacters)
    lazy var sellPrice: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.sellPrice, isEnabled: true, autocapitalize: .none)
    lazy var sellCommision: UITextField = createTextFields(placeholder: MultiCurrencyTextModel.sellCommision, isEnabled: true, autocapitalize: .none)
    
    //profit fields
    lazy var spreadPercentProfit: UITextField = createTextFields(placeholder: nil, isEnabled: false, autocapitalize: .none)
    lazy var moneyProfit: UITextField = createTextFields(placeholder: nil, isEnabled: false, autocapitalize: .none)

    //create lines

    
    
    
    private lazy var vBuyStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    private lazy var vSwapStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    private lazy var vSellStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    private lazy var vLineStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 40
        return $0
    }(UIStackView())
    
    private lazy var vProfitStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    private lazy var percentImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "ic-percent")
        return $0
    }(UIImageView())
    
    private lazy var profitImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "ic-dollar")
        return $0
    }(UIImageView())
    
    private lazy var countButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.text, for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "Count", attributes: [.font : UIFont(name: "K2D-Medium", size: 17) ?? ""]), for: .normal)
        $0.backgroundColor = .accent
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton(primaryAction: countProfitButton))
    
    lazy var countProfitButton: UIAction = UIAction { _ in
//        self.presenter.countSpreadAndProfit()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main

        view.addSubviews(highFigure, menuButton, titleLabel, addCircleHistoryPlusButton, bankTextField, bankImageView, buyLabel, swapLabel, sellLabel, vBuyStack, vSwapStack, vSellStack, vProfitStackView, countButton, percentImageView, profitImageView)
        
        vBuyStack.addArrangedSubview(buyCurrencyPair)
        vBuyStack.addArrangedSubview(buyPrice)
        vBuyStack.addArrangedSubview(buyCommision)
        
        vSwapStack.addArrangedSubview(swapCurrencyPair)
        vSwapStack.addArrangedSubview(swapPrice)
        vSwapStack.addArrangedSubview(swapCommision)
        
        vSellStack.addArrangedSubview(sellCurrencyPair)
        vSellStack.addArrangedSubview(sellPrice)
        vSellStack.addArrangedSubview(sellCommision)
        
        
        vProfitStackView.addArrangedSubview(spreadPercentProfit)
        vProfitStackView.addArrangedSubview(moneyProfit)

        setupConstraints()
    }
    
    func createTextFields(placeholder: String?, isEnabled: Bool, autocapitalize: UITextAutocapitalizationType) -> UITextField{
        let textField = UITextField()
        textField.frame.size = CGSize(width: 126, height: 40)
        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1), .font: UIFont(name: "K2D-ExtraLight", size: 12) ?? ""])
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        textField.backgroundColor = .lightMain
        textField.textColor = .accent
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.keyboardAppearance = .dark
        textField.textAlignment = .center
        textField.isEnabled = isEnabled
        textField.layer.cornerRadius = 5
        textField.autocapitalizationType = autocapitalize
        return textField
    }
    
    @objc
    func textDidChange(_ textField: UITextField){
        if let text = textField.text, !text.isEmpty {
            textField.font = UIFont(name: "K2D-Bold", size: 16)
        }else{
            textField.font = UIFont(name: "K2D-ExtraLight", size: 12)
        }
    }
    
    
    func createLine() -> UIView{
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightMain
        line.clipsToBounds = true
        return line
    }
    
    func createStackLine() -> UIView{
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.frame = CGRect(x: 0, y: 22, width: 65, height: 4)
        line.backgroundColor = .lightMain
        line.clipsToBounds = true
        return line
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            menuButton.heightAnchor.constraint(equalToConstant: 40),
            menuButton.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleLabel.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: addCircleHistoryPlusButton.leadingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            addCircleHistoryPlusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            addCircleHistoryPlusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            addCircleHistoryPlusButton.heightAnchor.constraint(equalToConstant: 40),
            addCircleHistoryPlusButton.widthAnchor.constraint(equalToConstant: 40),
            
            bankTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 273),
            bankTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bankTextField.heightAnchor.constraint(equalToConstant: 40),
            bankTextField.widthAnchor.constraint(equalToConstant: 173),
            
            bankImageView.topAnchor.constraint(equalTo: bankTextField.topAnchor, constant: 11),
            bankImageView.trailingAnchor.constraint(equalTo: bankTextField.trailingAnchor, constant: -6),
            bankImageView.widthAnchor.constraint(equalToConstant: 11),
            bankImageView.heightAnchor.constraint(equalToConstant: 18),
            
            buyLabel.topAnchor.constraint(equalTo: bankTextField.bottomAnchor, constant: 10),
            buyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            buyLabel.widthAnchor.constraint(equalToConstant: 93),
            buyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            swapLabel.topAnchor.constraint(equalTo: bankTextField.bottomAnchor, constant: 10),
            swapLabel.leadingAnchor.constraint(equalTo: buyLabel.trailingAnchor, constant: 0),
            swapLabel.trailingAnchor.constraint(equalTo: sellLabel.leadingAnchor, constant: 0),
            swapLabel.heightAnchor.constraint(equalToConstant: 20),
            
            sellLabel.topAnchor.constraint(equalTo: bankTextField.bottomAnchor, constant: 10),
            sellLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            sellLabel.widthAnchor.constraint(equalToConstant: 93),
            sellLabel.heightAnchor.constraint(equalToConstant: 20),
            
            vBuyStack.topAnchor.constraint(equalTo: buyLabel.bottomAnchor, constant: 9),
            vBuyStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            vBuyStack.widthAnchor.constraint(equalToConstant: 93),
            vBuyStack.heightAnchor.constraint(equalToConstant: 129),
            
            vSwapStack.topAnchor.constraint(equalTo: swapLabel.bottomAnchor, constant: 9),
            vSwapStack.leadingAnchor.constraint(equalTo: vBuyStack.trailingAnchor, constant: 20),
            vSwapStack.trailingAnchor.constraint(equalTo: vSellStack.leadingAnchor, constant: -20),
            vSwapStack.heightAnchor.constraint(equalToConstant: 129),
            
            
            vSellStack.topAnchor.constraint(equalTo: sellLabel.bottomAnchor, constant: 9),
            vSellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            vSellStack.widthAnchor.constraint(equalToConstant: 93),
            vSellStack.heightAnchor.constraint(equalToConstant: 129),
            
            vProfitStackView.topAnchor.constraint(equalTo: vBuyStack.bottomAnchor, constant: 16),
            vProfitStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 132),
            vProfitStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -133),
            vProfitStackView.heightAnchor.constraint(equalToConstant: 86),
            
            countButton.topAnchor.constraint(equalTo: vProfitStackView.bottomAnchor, constant: 54),
            countButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 132),
            countButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -133),
            countButton.heightAnchor.constraint(equalToConstant: 43),
            
            percentImageView.topAnchor.constraint(equalTo: spreadPercentProfit.topAnchor, constant: 11),
            percentImageView.trailingAnchor.constraint(equalTo: spreadPercentProfit.trailingAnchor, constant: -8),
            percentImageView.heightAnchor.constraint(equalToConstant: 18),
            percentImageView.widthAnchor.constraint(equalToConstant: 11),
            
            profitImageView.topAnchor.constraint(equalTo: moneyProfit.topAnchor, constant: 11),
            profitImageView.trailingAnchor.constraint(equalTo: moneyProfit.trailingAnchor, constant: -8),
            profitImageView.heightAnchor.constraint(equalToConstant: 18),
            profitImageView.widthAnchor.constraint(equalToConstant: 11),
            
        ])
    }
}
