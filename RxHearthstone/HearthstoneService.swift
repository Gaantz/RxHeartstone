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

enum HearthstoneError : Error {
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
        return responseJSON(url: Router.info).map({ Info(json: JSON($0))! })
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
}

