//
//  AlertMessage.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 22/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation


class AlertMessage: Error {
    
    var title =  ""
    var body =  ""
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}


class ErrorObject: Codable {
    let message: String
    let key: String?
}
