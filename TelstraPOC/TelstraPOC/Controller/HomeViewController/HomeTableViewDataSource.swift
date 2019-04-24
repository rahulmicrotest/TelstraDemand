//
//  HomeTableViewDataSource.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 23/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewDataSource: NSObject {
    
    // Home View Model reference to get No Of Rows and Data
    var homeViewModel: HomeViewModel
    
    // Initialization with View Model
    init(model: HomeViewModel){
        self.homeViewModel = model
    }
    

}

// Opt for Tableview Datasource to impliment two mandatory methods
extension HomeTableViewDataSource: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get No of Rows for Table View from View Model
        return (self.homeViewModel.numberOfRows(in: 1))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cell and convert it to ur custom Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let index = indexPath.row
        // Assign Model object to cell Model to create the each cell Data
        cell.model = HomeTableViewCell.Model(modelObj: self.homeViewModel.model, index: index)
        return cell
    }
    

}
