//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by user on 2022/6/10.
//

import Foundation

struct RegistrationViewModel: AuthenicationProtocol {
  
    var email: String?
    var password: String?
    var fullname: String?
    var usernam: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
        && fullname?.isEmpty == false
        && usernam?.isEmpty == false
    }
}
