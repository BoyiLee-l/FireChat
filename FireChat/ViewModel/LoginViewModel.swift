//
//  LoginViewModel.swift
//  FireChat
//
//  Created by user on 2022/6/9.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
