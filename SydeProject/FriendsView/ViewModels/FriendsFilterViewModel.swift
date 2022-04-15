//
//  FriendsFilterViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-29.
//

import Foundation

enum FriendsFilterViewModel: Int, CaseIterable {
    case friends
    case search
    
    var title: String {
        switch self {
        case .friends: return "Following"
        case .search:  return "Search"
        }
    }
}
