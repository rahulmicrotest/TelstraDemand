//
//  HomeTableViewCell.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 23/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    // Three Outlet for Each Cell
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    // general Model Object to set each model attribute in outlet
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            // Checking for null value
            titleLbl.text = model.title ?? ""
            descLbl.text = model.desc ?? ""
            
//            guard let imageURL = model.imageURL  else {
//                return
//            }
//            imageViewPhoto.setImage(with: imageURL)
        }
    }
}


extension HomeTableViewCell {
   // Creating general model object with All required Data
    struct Model {
        // two attributes
        let title: String?
        let desc: String?
        let imageURL: String?
        
        // Getting object form View Model cell for RowIndex
        init(modelObj: HomeModel, index: Int){
            title = modelObj.rows?[index].title
            desc = modelObj.rows?[index].description
            imageURL = modelObj.rows?[index].imageHref
        }
    }
}

