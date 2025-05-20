//
//  HistorySection.swift
//  P2PCount
//
//  Created by Dany on 12.05.2025.
//

import Foundation

struct HistorySection {
    
    var items: [HistoryItem]
    
    static func historyData() -> [HistorySection] {
        
        let history: [HistoryItem] = []
        let section = HistorySection(items: history)
        
        return [section]
    }
}
