//
//  InstagramRouter.swift
//  StalkYou
//
//  Created by Neha Yadav on 28/05/16.
//  Copyright © 2016 Neha Yadav. All rights reserved.
//

import Foundation
import Alamofire

enum InstagramRouter {
    
    case GetUserMedia(String, String)
    case GetUserMediaWithURL(String)
    
    var path: String {
        
        switch self {
        case .GetUserMedia(let user_id, _):
            return "https://api.instagram.com/v1/users/\(user_id)/media/recent/"
            
        case .GetUserMediaWithURL(let url):
            return url
        }
    }
    
    var method: Alamofire.Method {
        
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        
        switch self {
            
        case .GetUserMedia( _, let access_token):
            return ["access_token": access_token]
            
        default:
            return nil
        }
    }
    
    var body: AnyObject? {
        
        return nil
    }
    
    
    
}
