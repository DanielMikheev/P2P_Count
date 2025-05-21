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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneCellHistoryView.reuseIdentifier, for: indexPath) as! OneCellHistoryView
            cell.setData(data: data)
            return cell
       
    }
    
    

    
}
