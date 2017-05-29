//
//  HearthstoneService.swift
//  RxHearthstone
//
//  Created by Cristian Palomino Rivera on 28/05/17.
//  Copyright © 2017 Cristian Palomino Rivera. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxDataSources
import SwiftyJSON

enum HearthstoneError {
    case parseError
}

struct HearthstoneService {
    
    func responseJSON(url: URLRequestConvertible) -> Observable<Any> {
        return Observable.create { observer in
            let request = ApiManager.session.request(url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create(with: request.cancel)
        }
    }
    
    func responseCards(url: URLRequestConvertible) -> Observable<[Card]> {
        return Observable.create { observer in
            let request = ApiManager.session.request(url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(JSON(value).arrayValue.map({ json in
                        Card(json: json)!
                    }))
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create(with: request.cancel)
        }
    }
    
    func info() -> Observable<Info> {
        return responseJSON(url: Router.info)
            .map({ Info(json: JSON($0))! })
    }
    
    func cardsBy(clas: String) -> Observable<[Card]> {
        return responseJSON(url: Router.cardsByClass(clas: clas))
            .map({ result in
                JSON(result).arrayValue
            })
            .map({ json in
                json.map({ Card(json: $0)! })
            })
    }
    
    func bulk() -> Observable<[(String, [(String, Observable<[Card]>)])]> {
        let oinfo = info().map({ info in
            [
                ("Classes", info.classes.flatMap({ item in
                    (item, self.responseCards(url: Router.cardsByClass(clas: item)) )
                }) )
                /*
                ("Sets", [(info.sets, info.sets.map({ set in self.responseCards(url: Router.cardsBySet(set: set)) }).map({ $0 })) ]),
                ("Types", [(info.types, info.types.map({ type in self.responseCards(url: Router.cardsByType(type: type)) }).map({ $0 })) ]),
                ("Factions", [(info.factions, info.factions.map({ faction in self.responseCards(url: Router.cardsByFaction(faction: faction)) }).map({ $0 })) ]),
                ("Qualities", [(info.qualities, info.qualities.map({ quality in self.responseCards(url: Router.cardsByQuality(quality: quality)) }).map({ $0 })) ]),
                ("Races", [(info.races, info.races.map({ race in self.responseCards(url: Router.cardsByRace(race: race)) }).map({ $0 })) ])
                */
            ]
        })
        
        
        
        return oinfo
    }
}

