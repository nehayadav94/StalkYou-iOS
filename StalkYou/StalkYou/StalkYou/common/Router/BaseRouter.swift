//
//  BaseRouter.swift
//  StalkYou
//
//  Created by Neha Yadav on 28/05/16.
//  Copyright © 2016 Neha Yadav. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum BaseRouter: URLRequestConvertible {
    
    case InstagramRouteManager(InstagramRouter)
    
    var URLRequest: NSMutableURLRequest {
        
        switch self {
        case .InstagramRouteManager(let request):
            return self.configureRequest(request)
        }
    }
    
    func configureRequest(request: InstagramRouter) -> NSMutableURLRequest {
        
        let url = NSURL(string: request.path)!
        
        let mutableURLRequest = NSMutableURLRequest(URL: url)
        
        mutableURLRequest.HTTPMethod = request.method.rawValue
        
        if let parameters = request.parameters {
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        }
        
        return mutableURLRequest
    }
    
}

