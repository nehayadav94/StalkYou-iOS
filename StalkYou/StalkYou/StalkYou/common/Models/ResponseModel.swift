//
//  ResponseModel.swift
//  StalkYou
//
//  Created by Neha Yadav on 28/05/16.
//  Copyright © 2016 Neha Yadav. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

class ResponseModel: Object, Mappable {
    
    dynamic var pagination: PaginationModel?
    var mediaData = List<MediaModel>()
    
    required init?(_ map: Map) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    func mapping(map: Map) {
        
        pagination  <- map["pagination"]
        mediaData   <- (map["data"], ArrayTransform<MediaModel>())
    }
    
}

class PaginationModel: Object, Mappable {
    
    dynamic var next_url: String?
    dynamic var next_max_id: String?
    
    required init?(_ map: Map) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    func mapping(map: Map) {
        
        next_url    <- map["next_url"]
        next_max_id <- map["next_max_id"]
    }
}
