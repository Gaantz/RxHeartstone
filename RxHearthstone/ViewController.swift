//
//  ViewController.swift
//  RxHearthstone
//
//  Created by Cristian Palomino Rivera on 28/05/17.
//  Copyright © 2017 Cristian Palomino Rivera. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    var cards: Observable<[Card]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = HearthstoneService().info().map({ info in
            [
                SectionModel(model: "Patch", items: [info.patch]),
                SectionModel(model: "Classes", items: info.classes),
                SectionModel(model: "Sets", items: info.sets),
                SectionModel(model: "Types", items: info.types),
                SectionModel(model: "Factions", items: info.factions),
                SectionModel(model: "Qualities", items: info.qualities),
                SectionModel(model: "Races", items: info.races),
                SectionModel(model: "Locales", items: info.locales)
            ] as [SectionModel]
        })
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
        
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element)"
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }

        data.bindTo(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { indexPath in
            return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                
                HearthstoneService().cardsBy(clas: model).subscribe(
                    onNext: { value in
                        print(value)
                    },
                    onError: { error in
                        print(error)
                    },
                    onCompleted: { completed in
                        print("FINISH")
                    }
                    ).disposed(by: self.disposeBag)
                
            }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDelegate { }
