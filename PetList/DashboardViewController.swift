//
//  DashboardViewController.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    // MARK: UI outlets
    
    @IBOutlet weak var petTableView: UITableView!
    
    // MARK: Private

    private var petsDict = [String: [PetViewModel]]()
    
    // MARK: Override super methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register customized table cell
        self.petTableView.registerNib(UINib(nibName: String(PetTableViewCell), bundle: nil), forCellReuseIdentifier: PetTableViewCell.reuseIdentifier)

        //Set table delegate and datasource
        self.petTableView.delegate = self
        self.petTableView.dataSource = self
        
        //Init view model
        viewModel = DashboardViewModel()
        viewModel?.startAPIService()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: ViewModel
    
    var viewModel: DashboardViewModel? {
        didSet {
            viewModel?.petsByOwnerGenderDict.observe {
                [unowned self] in
                self.petsDict = $0
                self.petTableView.reloadData()
            }
        }
    }
}


// MARK: UITableViewDelegate/UITableViewDataSource as extension

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    
    //Section header title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = [String](self.petsDict.keys)
        return keys[section]
    }
    
    //Customized cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let keys = [String](self.petsDict.keys)
        let key = keys[indexPath.section]
        let pets = [PetViewModel](petsDict[key]!)
        
        let cell: PetTableViewCell = tableView.dequeueReusableCellWithIdentifier(PetTableViewCell.reuseIdentifier) as! PetTableViewCell
        cell.loadViewModel(pets[indexPath.row])
        
        return cell
    }
    
    //Number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let keys = [String](self.petsDict.keys)
        return keys.count
    }
    
    //Number of cells of each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = [String](self.petsDict.keys)
        let key = keys[section]
        let pets = petsDict[key]
        
        return pets!.count
    }
    
}


