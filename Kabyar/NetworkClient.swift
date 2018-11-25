//
//  NetworkClient.swift
//
//  Created by Win Than Htike on 11/15/18.
//  Copyright © 2018 MMDS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

public final class NetworkClient {
    
    private let baseURL: String
    
    private static var sharedNetworkManager: NetworkClient = {
        let url = SharedConstants.BASE_URL
        return NetworkClient(baseURL: url)
    }()
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    class func shared() -> NetworkClient {
        return sharedNetworkManager
    }
    
    public func getData(route : String,
                        headers : HTTPHeaders,
                        parameters : Parameters,
                        success : @escaping (Any) -> Void,
                        failure : @escaping (String) -> Void) {
        
        print("request url ==> \(baseURL + route)")
        
        Alamofire.request(baseURL + route, method: .get, parameters : parameters, headers : headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let api = response.result.value
                
                let json = JSON(api!)
                
                if json["errors"] == JSON.null {
                    
                    if let code = json["code"].int {
                        
                        if code.isResponseSuccess {
                            
                            success(json["data"])
                            
                        } else {
                            
                            failure(json["message"].string ?? "Unknow Error.")
                            
                        }
                        
                    } else {
                        
                        failure(json["message"].string ?? "Unknow Error.")
                        
                    }
                    
                } else {
                    
                    failure(json["message"].string ?? "Unknow Error.")
                    
                }
                
                break
                
            case .failure(let error):
                failure(error.localizedDescription)
                break
                
            }
            
        }
        
    }
    
    public func getDataList(route : String,
                        headers : HTTPHeaders,
                        parameters : Parameters,
                        success : @escaping ([Any]) -> Void,
                        failure : @escaping (String) -> Void) {
        
        print("request url ==> \(baseURL + route)")
        
        Alamofire.request(baseURL + route, method: .get, parameters : parameters, headers : headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let api = response.result.value
                
                let json = JSON(api!)
                
                if json["errors"] == JSON.null {
                    
                    if let code = json["code"].int {
                        
                        if code.isResponseSuccess {
                            
                            success(json["data"].array ?? [JSON]())
                            
                        } else {
                            
                            failure(json["message"].string ?? "Unknow Error.")
                            
                        }
                        
                    } else {
                        
                        failure(json["message"].string ?? "Unknow Error.")
                        
                    }
                    
                } else {
                    
                    failure(json["message"].string ?? "Unknow Error.")
                    
                }
                
                break
                
            case .failure(let error):
                print("sign up fail")
                failure(error.localizedDescription)
                break
                
            }
            
        }
        
    }
    
    public func postFormData(route : String,
                             headers : HTTPHeaders,
                             parameters : Parameters,
                             success : @escaping (Any) -> Void,
                             failure : @escaping (String) -> Void) {
        
        print("request url ==> \(baseURL + route)")
        
        Alamofire.request(baseURL + route, method: .post, parameters : parameters, encoding: URLEncoding.default, headers : headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let api = response.result.value
                
                let json = JSON(api!)
                
                if json["errors"] == JSON.null {
                    
                    if let code = json["code"].int {
                        
                        if code == SharedConstants.ResponseCode.SUCCESS {
                            
                            success(json["data"])
                            
                        } else {
                            
                            failure(json["message"].string ?? "Unknow Error.")
                            
                        }
                        
                    } else {
                        
                        failure(json["message"].string ?? "Unknow Error.")
                        
                    }
                    
                } else {
                    
                    failure(json["message"].string ?? "Unknow Error.")
                    
                }
                
                break
                
            case .failure(let error):
                print("sign up fail")
                failure(error.localizedDescription)
                break
                
            }
            
        }
        
    }
    
    public func postRawDataWithUrlRequest(request : URLRequest,
                                       success : @escaping (Any) -> Void,
                                       failure : @escaping (String) -> Void) {
        
        Alamofire.request(request).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let api = response.result.value
                
                let json = JSON(api!)
                
                let data = json["code"].int
                
                if let code = data {
                    
                    if code.isResponseSuccess {
                        
                        success(json["message"].string ?? "Success.")
                        
                    } else {
                        
                        failure(json["message"].string ?? SharedConstants.DEFAULT_ERROR_MESSAGE)
                        
                    }
                    
                } else {
                    
                    failure(json["message"].string ?? SharedConstants.DEFAULT_ERROR_MESSAGE)
                    
                }
                
                break
                
            case .failure(let error):
                failure(error.localizedDescription)
                break
                
            }
            
        }
        
    }
    
    public func postRawData(route : String,
                             headers : HTTPHeaders,
                             parameters : Parameters,
                             success : @escaping (Any) -> Void,
                             failure : @escaping (String) -> Void) {
        
        print("request url ==> \(baseURL + route)")
        
        Alamofire.request(baseURL + route, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let api = response.result.value
                
                let json = JSON(api!)
                
                if json["errors"] == JSON.null {
                    
                    if let code = json["code"].int {
                        
                        if code == SharedConstants.ResponseCode.SUCCESS {
                            
                            success(json["data"])
                            
                        } else {
                            
                            failure(json["message"].string ?? "Unknow Error.")
                            
                        }
                        
                    } else {
                        print(json)
                        failure(json["message"].string ?? "Unknow Error.")
                    }
                    
                } else {
                    
                    failure(json["message"].string ?? "Unknow Error.")
                    
                }
                
                break
                
            case .failure(let error):
                print("sign up fail")
                failure(error.localizedDescription)
                break
                
            }
            
        }
        
    }
    
    func uploadImage(route : String = SharedConstants.ApiRoute.ENDPOINT_UPLOAD_IMAGE,
                     data: Data?,
                     headers : HTTPHeaders,
                     parameters : Parameters,
                     success : @escaping (Any) -> Void,
                     progress : @escaping (Float) -> Void,
                     failure : @escaping (String) -> Void) {
        
        if let image = data {
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                multipartFormData.append(image, withName: "image",fileName: "profileImage\(Date().millisecondsSince1970).png", mimeType: "image/png")
                for (key, value) in parameters {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
                
            }, to: SharedConstants.BASE_URL + route, method : .post, headers : headers) { (result) in
                
                switch result {
                    
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (data) in
                        print("previousProgress Progress: \(Float(data.fractionCompleted))")
                        progress(Float(data.fractionCompleted))
                    })
                    
                    upload.responseJSON { response in
                        
                        let api = response.result.value
                        
                        if let api = api {
                                
                                let json = JSON(api)
                                
                                if json["errors"] == JSON.null {
                                    
                                    if let code = json["code"].int {
                                        
                                        if code.isResponseSuccess {
                                            
                                            success(json["url"].string ?? "")
                                            
                                        } else {
                                            
                                            failure(json["message"].string ?? "Unknow Error.")
                                            
                                        }
                                        
                                    } else {
                                        
                                    }
                                    
                                } else {
                                    
                                    failure(json["message"].string ?? "Unknow Error.")
                                    
                                }
                            
                        } else {
                            
                            failure("Please check your network connection.")
                            
                        }
                        
                    }
                    
                    break
                    
                case .failure(let error):
                    failure(error.localizedDescription)
                    break
                    
                }
                
            }
            
        }
        
    }
    
}
