//
//  AuthService.swift
//  FireChat
//
//  Created by DuncanLi on 2023/9/23.
//

import Firebase
import FirebaseFirestore

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        // 將 profileImage 轉換為 JPEG 格式的二進位數據
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        // 生成唯一的檔案名稱，用於存儲在 Firebase Storage 中
        let filename = NSUUID().uuidString
        
        // 創建 Firebase Storage
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        // 上傳圖像數據到 Firebase Storage
        ref.putData(imageData, metadata: nil) {(meta, error) in
            if let error = error {
                print("DEBUG Failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            // 從 Firebase Storage 下載圖像的下載URL
            ref.downloadURL {(url, error) in
                
                guard let profileImageUrl = url?.absoluteString else {
                    // URL 为空，可能需要处理这种情况
                    return
                }
                // 創建 Firebase 使用者帳號
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) {(result,error) in
                    if let error = error {
                        print("DEBUG Failed to upload image with error \(error.localizedDescription)")
                        return
                    }

                    // 從認證結果中獲取用戶ID
                    guard let uid = result?.user.uid else { return }

                    // 準備要保存到 Firestore 的用戶數據
                    let data = ["email": credentials.email,
                                "fullname": credentials.fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username] as [String : Any]

                    // 將用戶數據保存到 Firestore
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
}


