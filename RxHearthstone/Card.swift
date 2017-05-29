//
//  Card.swift
//  RxHearthstone
//
//  Created by Cristian Palomino Rivera on 28/05/17.
//  Copyright © 2017 Cristian Palomino Rivera. All rights reserved.
//

import Foundation
import SwiftyJSON

class Card: Mapeable {
    
    var cardId: String
    var name: String
    var cardSet: String
    var type: String
    var faction: String?
    var health: String?
    var rarity: String?
    var cost: Int?
    var text: String?
    var flavor: String?
    var artist: String?
    var collectible: Bool?
    var playerClass: String
    var img: String?
    var imgGold: String?
    var locale: String
    var mechanics: [String]?
    
    required init?(json: JSON) {
        
        guard
            let cardId = json["cardId"].string,
            let name = json["name"].string,
            let cardSet = json["cardSet"].string,
            let type = json["type"].string,
            let playerClass = json["playerClass"].string,
            let locale = json["locale"].string else {
            return nil
        }
        
        self.cardId = cardId
        self.name = name
        self.cardSet = cardSet
        self.type = type
        self.health = json["health"].string
        self.faction = json["faction"].string
        self.rarity = json["rarity"].string
        self.cost = json["cost"].int
        self.text = json["text"].string
        self.flavor = json["flavor"].string
        self.artist = json["artist"].string
        self.collectible = json["collectible"].bool
        self.playerClass = playerClass
        self.img = json["img"].string
        self.imgGold = json["imgGold"].string
        self.locale = locale
        self.mechanics = json["mechanics"].array?.map({ $0.stringValue })
    }
}
