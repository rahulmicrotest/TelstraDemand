//
//  UIImageView+Extension.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 24/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import  UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        let placeHolderImage = UIImage(named: Constants.placeHolderImage)
        self.kf.setImage(with: resource, placeholder: placeHolderImage, options: [.forceRefresh])
    }
}
