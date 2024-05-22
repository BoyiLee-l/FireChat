//
//  ProfileViewModel.swift
//  FireChat
//
//  Created by Duncan Li on 2024/5/22.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo:
            return "Account Info"
        case .settings:
            return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo:
            return "person.circle"
        case .settings:
            return "gear"
        }
    }
}
