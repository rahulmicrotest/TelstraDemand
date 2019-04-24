//
//  HomeViewModel.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 22/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private let apiManager = APIManager()
    var model = HomeModel(title:"", rows: [])
    
    func fetchRequest(handler: @escaping (Bool, AlertMessage?) -> ()) {
        apiManager.fetchData(type: EndPointItem.telstra1,
                             handler:{ (model: HomeModel?, message: AlertMessage?) in
          
            guard message == nil else {
                return handler(false, message)
            }
                                
            guard let model = model else {
                return handler(false, message)
            }
            self.model = model
            
            ///filter the empty dictionaries
            self.filterParsed(data: self.model)

            if self.model.rows != nil {
              handler(true, nil)
            }else {
              handler(false, message)
            }
        })
    }
    
    
    //returns the count of the items to be displayed in the collectionview
    func numberOfRows(in section: Int) -> Int {
        return self.model.rows?.count ?? 0
    }

    
    ///set the main title and the rows (filters the empty dict also)
    private func filterParsed(data: HomeModel) {
        self.model.title = data.title ?? Constants.noTitle
        
        if let rowArray = data.rows {
            ///Filter the data : remove nil values from dictionaries
            let filterData = rowArray.filter {($0.title != nil) ||
                ($0.description != nil) ||
                ($0.imageHref != nil)}
            self.model.rows = filterData
        } else {
            self.model.rows = nil///the rowsArray is with correupted data or wrong key was used
        }
    }
    
    ///returns the title of the Screen
    func screenTitle() -> String? {
        return self.model.title
    }

}
