//
//  CellHistoryView.swift
//  P2PCount
//
//  Created by Dany on 12.05.2025.
//

import UIKit

protocol CellHistoryViewProtocol: AnyObject {
    func setData(data: Histories)
}

class CellHistoryView: UICollectionViewCell, CellHistoryViewProtocol{
    static let reuseIdentifier: String = "OneCellHistoryView"
    var deleteButtonAction: ((UICollectionViewCell) -> Void)?
    
    lazy var historyView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CGColor(red: 33/255, green: 46/255, blue: 79/255, alpha: 1)
        return $0
    }(UIView())
    
    lazy var oneTableImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    //head stack
    lazy var hHeadStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 55
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    lazy var editButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "ic-edit"), for: .normal)
        $0.tintColor = .text
        return $0
    }(UIButton(primaryAction: editAction))
    
    lazy var editAction: UIAction = UIAction { _ in
        
    }
    
    lazy var date: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "K2D-Bold", size: 11)
        $0.textColor = .text
        $0.numberOfLines = 1
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var deleteHistoryButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "ic-trash"), for: .normal)
        $0.tintColor = UIColor(red: 241/255, green: 36/255, blue: 26/255, alpha: 1)
        return $0
    }(UIButton(primaryAction: deleteAction))
      
    lazy var deleteAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.deleteButtonAction?(self)
    }
    
    //table stack
    
    lazy var hTableStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    //first column text stack
    
    lazy var vFirstColumnStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    lazy var exchangeTextLabel = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var currencyPairTextLabel = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var priceTextLabel = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var comissionTextLabel = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var profitTextLabel = createTextLabel(font: UIFont(name: "K2D-Bold", size: 11), alignment: .left)
    
    //buy column stack
    lazy var buyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = UIFont(name: "K2D-Light", size: 11)
        $0.textAlignment = .center
        $0.textColor = .accent
        return $0
    }(UILabel())
    
    lazy var vSecondColumnStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    lazy var buyNameExchange = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var buyNameCurrencyPair = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var buyPrice = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var buyCommision = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    
    // swap column stack
    
    lazy var swapLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = UIFont(name: "K2D-Light", size: 11)
        $0.textAlignment = .center
        $0.textColor = .accent
        return $0
    }(UILabel())
    
    lazy var vSwapColumnStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    lazy var swapNameExchange = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var swapNameCurrencyPair = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var swapPrice = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var swapCommision = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    
    
    
    //sell column stack
    lazy var sellLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = UIFont(name: "K2D-Light", size: 11)
        $0.textAlignment = .center
        $0.textColor = .accent
        return $0
    }(UILabel())
    
    lazy var vThirdColumnStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    lazy var sellNameExchange = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var sellNameCurrencyPair = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var sellPrice = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var sellCommision = createTextLabel(font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    
    //profit value labels
    
    lazy var moneyAndSpreadProfitLabel = createTextLabel(font: UIFont(name: "K2D-Bold", size: 11), alignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(historyView, oneTableImageView, hHeadStack, hTableStack, moneyAndSpreadProfitLabel)
        
        hHeadStack.addArrangedSubview(editButton)
        hHeadStack.addArrangedSubview(date)
        hHeadStack.addArrangedSubview(deleteHistoryButton)
        
        hTableStack.addArrangedSubview(vFirstColumnStack)
        hTableStack.addArrangedSubview(vSecondColumnStack)
        hTableStack.addArrangedSubview(vSwapColumnStack)
        hTableStack.addArrangedSubview(vThirdColumnStack)
        
        vFirstColumnStack.addArrangedSubview(UIView())
        vFirstColumnStack.addArrangedSubview(exchangeTextLabel)
        vFirstColumnStack.addArrangedSubview(currencyPairTextLabel)
        vFirstColumnStack.addArrangedSubview(priceTextLabel)
        vFirstColumnStack.addArrangedSubview(comissionTextLabel)
        vFirstColumnStack.addArrangedSubview(profitTextLabel)
        
        vSecondColumnStack.addArrangedSubview(buyLabel)
        vSecondColumnStack.addArrangedSubview(buyNameExchange)
        vSecondColumnStack.addArrangedSubview(buyNameCurrencyPair)
        vSecondColumnStack.addArrangedSubview(buyPrice)
        vSecondColumnStack.addArrangedSubview(buyCommision)
        vSecondColumnStack.addArrangedSubview(UIView())
        
        vSwapColumnStack.addArrangedSubview(swapLabel)
        vSwapColumnStack.addArrangedSubview(swapNameExchange)
        vSwapColumnStack.addArrangedSubview(swapNameCurrencyPair)
        vSwapColumnStack.addArrangedSubview(swapPrice)
        vSwapColumnStack.addArrangedSubview(swapCommision)
        vSwapColumnStack.addArrangedSubview(UIView())
        
        vThirdColumnStack.addArrangedSubview(sellLabel)
        vThirdColumnStack.addArrangedSubview(sellNameExchange)
        vThirdColumnStack.addArrangedSubview(sellNameCurrencyPair)
        vThirdColumnStack.addArrangedSubview(sellPrice)
        vThirdColumnStack.addArrangedSubview(sellCommision)
        vThirdColumnStack.addArrangedSubview(UIView())
        
        
        setupConstraints()
        
        
    }
       
    
    
    func setData(data: Histories){
        self.exchangeTextLabel.text = "Exchange"
        self.currencyPairTextLabel.text = "Pair"
        self.priceTextLabel.text = "Price"
        self.comissionTextLabel.text = "Comission"
        self.profitTextLabel.text = "Profit"
        self.date.text = data.date
        self.buyLabel.text = data.buy
        self.buyNameExchange.text = data.buyNameExchange
        self.buyNameCurrencyPair.text = data.buyCurrencyPair
        self.buyPrice.text = data.buyPrice
        self.buyCommision.text = data.buyCommision
        self.swapLabel.text = data.swap
        self.swapNameExchange.text = data.swapNameExchange
        self.swapNameCurrencyPair.text = data.swapCurrencyPair
        self.swapPrice.text = data.swapPrice
        self.swapCommision.text = data.swapCommision
        self.sellLabel.text = data.sell
        self.sellNameExchange.text = data.sellNameExchange
        self.sellNameCurrencyPair.text = data.sellCurrencyPair
        self.sellPrice.text = data.sellPrice
        self.sellCommision.text = data.sellCommision
        self.moneyAndSpreadProfitLabel.text = data.profitAndSpreadResult
    }

    
    func setDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func createTextLabel(font: UIFont?, alignment: NSTextAlignment) -> UILabel{
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = font
        textLabel.textAlignment = alignment
        textLabel.numberOfLines = 2
        textLabel.textColor = .text
        return textLabel
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            historyView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            historyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            historyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            historyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            hHeadStack.topAnchor.constraint(equalTo: historyView.topAnchor, constant: 12),
            hHeadStack.leadingAnchor.constraint(equalTo: historyView.leadingAnchor, constant: 19),
            hHeadStack.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -19),
            hHeadStack.heightAnchor.constraint(equalToConstant: 22),
            
            hTableStack.topAnchor.constraint(equalTo: hHeadStack.bottomAnchor, constant: 50),
            hTableStack.leadingAnchor.constraint(equalTo: historyView.leadingAnchor, constant: 19),
            hTableStack.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -19),
            hTableStack.bottomAnchor.constraint(equalTo: historyView.bottomAnchor, constant: -19),
            
            moneyAndSpreadProfitLabel.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -19),
            moneyAndSpreadProfitLabel.bottomAnchor.constraint(equalTo: historyView.bottomAnchor, constant: -19),
            moneyAndSpreadProfitLabel.heightAnchor.constraint(equalToConstant: 21),
            moneyAndSpreadProfitLabel.widthAnchor.constraint(equalToConstant: 195),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
