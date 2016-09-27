//
//  PetTableViewCell.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import UIKit

// MARK: - Constants

let kReuseIdentifier: String = "PetTableViewCell"

class PetTableViewCell: UITableViewCell {
    
    // MARK: UI outlets
    
    @IBOutlet weak var petIconImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    
    // MARK: Class method
    
    class var reuseIdentifier: String {
        get {
             //reuse identifier
            return kReuseIdentifier
        }
    }
    
    // MARK: Override super methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: ViewModel
    
    var viewModel: PetViewModel? {
        didSet {
            viewModel?.name.observe {
                [unowned self] in
                self.petNameLabel.text = $0
            }
            
            //Hard code dot icon, can be dynamic as well
           self.petIconImageView.image = UIImage(named: "dot.png")
        }
    }
    
    // MARK: Public method
    
    // Init view model
    func loadViewModel(viewModel: PetViewModel) {
        self.viewModel = viewModel
    }
    
}
