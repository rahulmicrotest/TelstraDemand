//
//  HomeModel.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 22/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation


struct HomeModel: Codable {
    var title: String?
    var rows: [Rows]?
}

struct Rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
