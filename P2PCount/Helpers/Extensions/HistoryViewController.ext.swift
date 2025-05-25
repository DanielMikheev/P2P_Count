//
//  HistoryViewController.ext.swift
//  P2PCount
//
//  Created by Dany on 12.05.2025.
//

import UIKit


extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let data = self.presenter.allItems[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellHistoryView.reuseIdentifier, for: indexPath) as! CellHistoryView
            cell.setData(data: data)
            
            cell.deleteButtonAction = { [weak self] cell in
            guard let self = self else { return }
            self.presenter.deleteItem(cell)
            self.presenter.dataManager.deleteHistory(history: data)
            self.presenter.dataManager.saveContext()
        }
            return cell
       
    }
}

