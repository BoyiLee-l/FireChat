//
//  Service.swift
//  FireChat
//
//  Created by DuncanLi on 2023/9/23.
//

import Foundation
import Firebase

class Service {
    
    static func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                print(document.data())
            })
        }
    }
}
