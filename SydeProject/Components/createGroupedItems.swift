//
//  createGroupedItems.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-17.
//

import Foundation
import SwiftUI

func createGroupedItems(items: [String], screenWidth:CGFloat, extraWidth:CGFloat)  -> [[String]] {
    
    var groupedItems: [[String]] = [[String]]()
    var tempItems: [String] = [String]()
    var width: CGFloat = 0
    
    for word in items {
        let label = UILabel()
        label.text = word
        label.sizeToFit()
        
        let labelWidth = label.frame.size.width + extraWidth
        
        if (width + labelWidth + extraWidth) < screenWidth {
            width += labelWidth
            tempItems.append(word)
        } else {
            width = labelWidth
            groupedItems.append(tempItems)
            tempItems.removeAll()
            tempItems.append(word)
        }
    }
    
    groupedItems.append(tempItems)
    
    return groupedItems
}
