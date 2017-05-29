//
//  Info.swift
//  RxHearthstone
//
//  Created by Cristian Palomino Rivera on 28/05/17.
//  Copyright © 2017 Cristian Palomino Rivera. All rights reserved.
//

import Foundation
import SwiftyJSON

class Info: Mapeable {
    
    var patch: String
    var classes: [String]
    var sets: [String]
    var types: [String]
    var factions: [String]
    var qualities: [String]
    var races: [String]
    var locales: [String]
        
    required init?(json: JSON) {
        
        guard
            let patch = json["patch"].string,
            let classes = json["classes"].array,
            let sets = json["sets"].array,
            let types = json["types"].array,
            let factions = json["factions"].array,
            let qualities = json["qualities"].array,
            let races = json["races"].array,
            let locales = json["locales"].array else {
                return nil
        }
        
        self.patch = patch
        self.classes = classes.map({ $0.stringValue })
        self.sets = sets.map({ $0.stringValue })
        self.types = types.map({ $0.stringValue })
        self.factions = factions.map({ $0.stringValue })
        self.qualities = qualities.map({ $0.stringValue })
        self.races = races.map({ $0.stringValue })
        self.locales = locales.map({ $0.stringValue })
    }
}
