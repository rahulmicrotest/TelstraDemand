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
    private var refreshController:UIRefreshControl! = nil
    
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
        
        // Set pull to refresh
        configurePullToRefresh()
        
        // Fetch Data using ViewModel and Alamofire
        loadData()
    }
    
    
    
}

//

private extension HomeViewController {
    
    // Settings for Pull To Refresh Object
    func configurePullToRefresh(){
        self.refreshController  = UIRefreshControl()
        self.refreshController.tintColor = UIColor.red
        self.refreshController.attributedTitle = NSAttributedString(string: Constants.pullToRefresh)
        self.refreshController.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        self.tableViewHome.addSubview(self.refreshController)
    }
    
    // Calling Objective C Selector method after pulling
    @objc func pullToRefresh(sender: AnyObject){
        loadData()
        stopPullToRefresh()
    }
    
    // Stopping Pull To Refresh
    func stopPullToRefresh(){
        self.refreshController.endRefreshing()
    }
    
    // To get call back from ViewModel after fetching Data and reload TableView
    func loadData() {
        
        // STart Activity Indiacator
        shouldHideLoader(isHidden: false)
        
        // Call Few Model FetchRequest to get callback success/ Failure
        viewModel.fetchRequest { (status, errorMessage) in
            
            switch status {
                case true:
                    // Pass ViewModel Object to DataSource to set Table
                    self.dataSource = HomeTableViewDataSource(model: self.viewModel)
                    
                    // Assign Data Source to tableView DataSource
                    self.tableViewHome.dataSource = self.dataSource
                    
                    // Setting Title
                    self.title = self.viewModel.screenTitle()
                    
                    // Call Reload TableView
                    self.tableViewHome.reloadData()
                
                case false:
                    self.showAlertWith(message: errorMessage ?? AlertMessage(title: "Error", body:Constants.generalErrorMessage))
            }
            // Stop Activity Indiacator either success/Failure
            self.shouldHideLoader(isHidden: true)

        }
    }
}
