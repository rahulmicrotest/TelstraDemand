//
//  HomeViewController.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 22/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // Table View IBOutlet to Reload TableView
    @IBOutlet weak var tableViewHome: UITableView!
    
    // declare RefreshController for Pull to refresh
    private let refreshController:UIRefreshControl! = nil
    
    //declare DataSource , responsible for no of rows and tableview Cell configuration
    private var dataSource: HomeTableViewDataSource!

    //Define View Model, to call fetch Data method in View Model
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch Data using ViewModel and Alamofire
        loadData()
    }
    
    
    
}

//

private extension HomeViewController {
    // To get call back from ViewModel after fetching Data and reload TableView
    func loadData() {
        
        // STart Activity Indiacator
        shouldHideLoader(isHidden: false)
        
        // Call Few Model FetchRequest to get callback success/ Failure
        viewModel.fetchRequest { (status, errorMessage) in
            if status == true {
                // Pass ViewModel Object to DataSource to set Table
                self.dataSource = HomeTableViewDataSource(model: self.viewModel)
                
                // Assign Data Source to tableView DataSource
                self.tableViewHome.dataSource = self.dataSource
                
                // Call Reload TableView
                self.tableViewHome.reloadData()
            }else if status == false {
                print(status)
            }
            // Stop Activity Indiacator either success/Failure
            self.shouldHideLoader(isHidden: true)
       }
    }
    
}
