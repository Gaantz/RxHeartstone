//
//  ApiManager.swift
//  RxHearthstone
//
//  Created by Cristian Palomino Rivera on 28/05/17.
//  Copyright © 2017 Cristian Palomino Rivera. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ApiManager {
    
    public static let session: SessionManager = {

        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["X-Mashape-Key"] = "BRGxteEFzFmshQItCIFu8g5ntVrKp15JpkFjsnr8kbh1losdFD"
        defaultHeaders["Accept"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
}

protocol Mapeable {
    
    init?(json :JSON)
}
