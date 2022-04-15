//
//  HomeFilterViewModel.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import Foundation

enum HomeFilterViewModel: Int, CaseIterable {
    case yourFeed
    case joinTeam
    case donateCode
    
    var title: String {
        switch self {
        case .yourFeed: return "Your Feed"
        case .joinTeam: return "Join a Team"
        case .donateCode: return "Donate Code"
        }
    }
}
