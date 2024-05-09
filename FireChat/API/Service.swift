//
//  Service.swift
//  FireChat
//
//  Created by DuncanLi on 2023/9/23.
//

import Foundation
import Firebase

class Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        COLLECTION_MESSAGE.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGE.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        }
    }
}

