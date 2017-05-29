//
//  Router.swift
//  RxHearthstone
//
//  Created by Cristian Palomino Rivera on 28/05/17.
//  Copyright © 2017 Cristian Palomino Rivera. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case info
    case card(name: String)
    case cards
    case cardBacks
    case search(name: String)
    case cardsBySet(set: String)
    case cardsByClass(clas: String)
    case cardsByFaction(faction: String)
    case cardsByQuality(quality: String)
    case cardsByRace(race: String)
    case cardsByType(type: String)
    
    static let baseURLString = "https://omgvamp--hearthstone--v1-p-mashape-com-yzsfvdohqwc1.runscope.net"
    
    var method: HTTPMethod {
        switch self {
        case .info,
             .card,
             .cards,
             .cardBacks,
             .search,
             .cardsBySet,
             .cardsByClass,
             .cardsByFaction,
             .cardsByQuality,
             .cardsByRace,
             .cardsByType:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .info:
            return "/info"
        case .card(let name):
            return "/cards/\(name)"
        case .cards:
            return "/cards"
        case .cardBacks:
            return "/cardbacks"
        case .search(let name):
            return "/cards/search/\(name)"
        case .cardsBySet(let set):
            return "/cards/sets/\(set)"
        case .cardsByClass(let clas):
            return "/cards/classes/\(clas)"
        case .cardsByFaction(let faction):
            return "/cards/factions/\(faction)"
        case .cardsByQuality(let quality):
            return "/cards/qualities/\(quality)"
        case .cardsByRace(let race):
            return "/cards/races/\(race)"
        case .cardsByType(let type):
            return "/cards/types/\(type)"
        }
    }
    
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    func asURLRequest() throws -> URLRequest {
        
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .info:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .card:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cards:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardBacks:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .search:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardsBySet:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardsByClass:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardsByFaction:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardsByQuality:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardsByRace:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .cardsByType:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        
        return urlRequest
    }
}
