//
//  CellHistoryView.swift
//  P2PCount
//
//  Created by Dany on 12.05.2025.
//

import UIKit

protocol OneCellHistoryViewProtocol: AnyObject {
    func setData(data: HistoryItem)
}

class OneCellHistoryView: UICollectionViewCell, OneCellHistoryViewProtocol{
    static let reuseIdentifier: String = "OneCellHistoryView"
    
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
        $0.spacing = 65
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
      
    lazy var deleteAction: UIAction = UIAction { _ in
        
    }
    
    //table stack
    
    lazy var hTableStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 20
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
    
    lazy var exchangetTextLabel = createTextLabel(text: "Exchange", font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var currencyPairTextLabel = createTextLabel(text: "Currency Pair", font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var priceTextLabel = createTextLabel(text: "Price", font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var comissiontTextLabel = createTextLabel(text: "Commision", font: UIFont(name: "K2D-Light", size: 11), alignment: .left)
    lazy var profitTextLabel = createTextLabel(text: "Profit/Spread", font: UIFont(name: "K2D-Bold", size: 11), alignment: .left)
    
    //second column stack
    lazy var buyLabel: UILabel = {
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
    
    lazy var buyNameExchange = createTextLabel(text: "Bybit", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var buyNameCurrencyPair = createTextLabel(text: "RUB/USDT", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var buyPrice = createTextLabel(text: "90.4", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var buyCommision = createTextLabel(text: "0.1", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    
    //third column stack
    lazy var sellLabel: UILabel = {
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
    
    lazy var sellNameExchange = createTextLabel(text: "OKX", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var sellNameCurrencyPair = createTextLabel(text: "USDT/RUB", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var sellPrice = createTextLabel(text: "92.5", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    lazy var sellCommision = createTextLabel(text: "0.1", font: UIFont(name: "K2D-Light", size: 11), alignment: .center)
    
    //profit value labels
    
    lazy var moneyAndSpreadProfitLabel = createTextLabel(text: "3280 $ / 2.35 %", font: UIFont(name: "K2D-Bold", size: 11), alignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(historyView, oneTableImageView, hHeadStack, hTableStack, moneyAndSpreadProfitLabel)
        
        hHeadStack.addArrangedSubview(editButton)
        hHeadStack.addArrangedSubview(date)
        hHeadStack.addArrangedSubview(deleteHistoryButton)
        
        hTableStack.addArrangedSubview(vFirstColumnStack)
        hTableStack.addArrangedSubview(vSecondColumnStack)
        hTableStack.addArrangedSubview(vThirdColumnStack)
        
        vFirstColumnStack.addArrangedSubview(exchangetTextLabel)
        vFirstColumnStack.addArrangedSubview(currencyPairTextLabel)
        vFirstColumnStack.addArrangedSubview(priceTextLabel)
        vFirstColumnStack.addArrangedSubview(comissiontTextLabel)
        vFirstColumnStack.addArrangedSubview(profitTextLabel)
        
        vSecondColumnStack.addArrangedSubview(buyNameExchange)
        vSecondColumnStack.addArrangedSubview(buyNameCurrencyPair)
        vSecondColumnStack.addArrangedSubview(buyPrice)
        vSecondColumnStack.addArrangedSubview(buyCommision)
        vSecondColumnStack.addArrangedSubview(UIView())
        
        vThirdColumnStack.addArrangedSubview(sellNameExchange)
        vThirdColumnStack.addArrangedSubview(sellNameCurrencyPair)
        vThirdColumnStack.addArrangedSubview(sellPrice)
        vThirdColumnStack.addArrangedSubview(sellCommision)
        vThirdColumnStack.addArrangedSubview(UIView())
        
        
        setupConstraints()
        
    }
    

       
    
    
    func setData(data: HistoryItem){
        date.text = "Date: \(self.setDate())"
    }

    
    func setDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func createTextLabel(text: String?, font: UIFont?, alignment: NSTextAlignment) -> UILabel{
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = text
        textLabel.font = font
        textLabel.textAlignment = alignment
        textLabel.numberOfLines = 1
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
            
            hTableStack.topAnchor.constraint(equalTo: hHeadStack.bottomAnchor, constant: 80),
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
