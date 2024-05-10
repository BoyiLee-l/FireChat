//
//  MessageViewModel.swift
//  FireChat
//
//  Created by Duncan Li on 2024/5/9.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0) : .systemPurple
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
    }
    
    init(message: Message) {
        self.message = message
    }
}
