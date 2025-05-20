//
//  HistoryViewController.ext.swift
//  P2PCount
//
//  Created by Dany on 12.05.2025.
//

import UIKit


extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.presenter.historySection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.historySection[0].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.presenter.historySection[indexPath.section].items[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneCellHistoryView.reuseIdentifier, for: indexPath) as! OneCellHistoryView
        cell.setData(data: item)
        
        return cell
    }
    
    

    
}
