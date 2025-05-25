//
//  HistoryViewController.swift
//  P2PCount
//
//  Created by Dany on 08.05.2025.
//

import UIKit
import CoreData

protocol HistoryViewControllerProtocol: AnyObject {
    var historyCollectionView: UICollectionView { get set }
}

class HistoryViewController: UIViewController, HistoryViewControllerProtocol{
    
    var presenter: HistoryViewPresenterProtocol!
    
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
        $0.text = "History"
        $0.font = UIFont(name: "K2D-Medium", size: 20)
        $0.textColor = .text
        $0.numberOfLines = 1
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var historyCollectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.clipsToBounds = true
        $0.backgroundColor = .main
        $0.register(CellHistoryView.self, forCellWithReuseIdentifier: CellHistoryView.reuseIdentifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: setLayout()))
    
    private func setLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, environment in
            switch section{
            default:
                self.setSectionLayout()
            }
        }
    }
        
        func setSectionLayout() -> NSCollectionLayoutSection {
            //1 - create item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            //2 - create group
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(313), heightDimension: .absolute(313))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            //3 - create section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 141, leading: 40, bottom: 144, trailing: 40)
            section.interGroupSpacing = 100
            return section
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .main
            view.addSubviews(highFigure, menuButton, titleLabel, historyCollectionView)
            setupConstraints()
            
        }
    
        
        func setupConstraints(){
            NSLayoutConstraint.activate([
                menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
                menuButton.heightAnchor.constraint(equalToConstant: 40),
                menuButton.widthAnchor.constraint(equalToConstant: 40),
                
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
                titleLabel.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 96),
                titleLabel.widthAnchor.constraint(equalToConstant: 70),
                titleLabel.heightAnchor.constraint(equalToConstant: 22),
                
                historyCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
                historyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                historyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
                
                
                
            ])
    }
}
