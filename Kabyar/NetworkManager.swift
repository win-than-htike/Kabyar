//
//  NetworkManager.swift
//  Kabyar
//
//  Created by Win Than Htike on 11/22/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class NetworkManager {
    
    let rootRef : DatabaseReference!
    
    let storageRef = Storage.storage().reference().child("images")
    
    private init() {
        rootRef = Database.database().reference()
    }
    
    static var shared : NetworkManager =  {
        return sharedNetworkManager
    }()
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func loadPosts(success : @escaping ([PostVO]) -> Void, failure : @escaping () -> Void) {
        
        rootRef.child("kabyar").observe(.value) { (dataSnapshot) in
            
            if let posts = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                var postList : [PostVO] = []
                
                for post in posts {
                    
                    if let value = post.value as? [String : AnyObject] {
                        
                        postList.append(PostVO.parseToPostVO(json: value))
                        
                    }
                    
                }
                
                success(postList)
                
            }
            
        }
        
    }
    
    func login(email : String, password : String, success : @escaping (UserVO) -> Void, failure : @escaping () -> Void) {
        
        rootRef.child("users").observe(.value) { (dataSnapshot) in
            
            if let users = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                for user in users {
                    
                    if let value = user.value as? [String : AnyObject] {
                        
                        let userVO = UserVO.parseToUserVO(json: value)
                        
                        print("\(userVO.email ?? "") and \(userVO.password ?? "Default")")
                        print("\(email) and \(password)")
                        
                        if email == userVO.email ?? "" && password == userVO.password ?? "" {
                            success(userVO)
                            return
                        } else {
                            
                        }
                        
                    } else {
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func addPost(post : PostVO, success : @escaping () -> Void, failure : @escaping () -> Void) {
        
        rootRef.child("kabyar").child(post.id).setValue(PostVO.parseToDictionary(post: post))
        success()
        
    }
    
    func imageUpload(data : Data?, success : @escaping (String) -> Void, failure : @escaping () -> Void) {
        
        if let imageData = data {
            
            let uploadImageRef = storageRef.child("\(Date().millisecondsSince1970).png")
            
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                
                print(metadata ?? "NO METADATA")
                print(error ?? "NO ERROR")
                
                uploadImageRef.downloadURL(completion: { (url, error) in
                    
                    if let error = error {
                        print(error)
                    }
                    
                    if let url = url {
                     print(url.absoluteString)
                     success(url.absoluteString)
                    } else {
                        failure()
                    }
                    
                })
                
            }
            
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "NO MORE PROGRESS")
            }
            
            uploadTask.resume()
            
        }
        
    }
    
}
