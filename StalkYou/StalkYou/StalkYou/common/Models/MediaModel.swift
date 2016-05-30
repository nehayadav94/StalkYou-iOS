//
//  MediaModel.swift
//  StalkYou
//
//  Created by Neha Yadav on 28/05/16.
//  Copyright © 2016 Neha Yadav. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

class Image: Object, Mappable {
    
    dynamic var url: String?
    dynamic var width = 0
    dynamic var height = 0
    
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
        
        url     <- map["url"]
        width   <- map["width"]
        height  <- map["height"]
    }
}

class ImageObject: Object, Mappable {
    
    dynamic var thumbnail: Image?
    dynamic var low_resolution: Image?
    dynamic var standard_resolution: Image!
    
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
        
        thumbnail   <- map["thumbnail"]
        low_resolution  <- map["low_resolution"]
        standard_resolution <- map["standard_resolution"]
    }
}


class MediaModel: Object, Mappable {
    
    dynamic var id: String?
    dynamic var images: ImageObject?
    dynamic var caption: CaptionObject?
    dynamic var user: UserObject?
    dynamic var user_id: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
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
        
        id      <- map["id"]
        images  <- map["images"]
        caption <- map["caption"]
        user    <- map["user"]
        
        if let user_id = self.user?.id {
            self.user_id = user_id
        }
    }
}

class UserObject: Object, Mappable {
    
    dynamic var id: String?
    dynamic var username: String?
    dynamic var profile_picture: String?
    
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
        
        id  <- map["id"]
        username    <- map["username"]
        profile_picture <- map["profile_picture"]
    }
}

class CaptionObject: Object, Mappable {
    
    dynamic var text: String?
    dynamic var created_time: String?
    
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
        
        text    <- map["text"]
        created_time <- map["created_time"]
    }
}
