//
//  TableViewCell.swift
//  SearchTableView
//
//  Created by HIRANO TOMOKAZU on 3/2/16.
//  Copyright © 2016 Akihiro Ito. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var imageUrl: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Generic Cell Initialization Done")
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.button.layer.borderWidth = 2
        self.button.layer.borderColor = UIColor(red: 58.0/255.0, green: 108.0/255.0, blue: 219.0/255.0, alpha: 1.0).CGColor
 
        //if Share.sharedInstance.tabButton {
            //self.imageUrl.layer.cornerRadius = self.imageUrl.frame.size.width / 2
            //self.imageUrl.clipsToBounds = true
        //}
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class TableViewCell1: TableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Generic Cell1 Initialization Done")
        //self.imageUrl.layer.cornerRadius = self.imageUrl.frame.size.width
        //self.imageUrl.clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class TableViewCell2: TableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Generic Cell2 Initialization Done")
        //self.imageUrl.layer.cornerRadius = self.imageUrl.frame.size.width / 2
        //self.imageUrl.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
