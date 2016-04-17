//
//  ViewController.swift
//  SearchTableView
//
//  Created by HIRANO TOMOKAZU on 3/2/16.
//  Copyright © 2016 Akihiro Ito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var VXWL_pre: UILabel!
    @IBOutlet weak var VXWL: UILabel!
    @IBOutlet weak var User_pre: UILabel!
    @IBOutlet weak var User: UILabel!
    
    var items = NSMutableArray()
    
    var searchActive :  Bool = false
    var tabBtn : Bool = false
    var sharedTab = Share.sharedInstance
    
    var picUrl:         [String] = []
    var name:           [String] = []
    var desc:           [String] = []
    
    var datas: [JSON] = []
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        VXWL.text = "VXWL(0)"
        User.text = "User(0)"
        
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        //textFieldInsideSearchBar?.leftViewMode = UITextFieldViewMode.Never
        self.searchBar.setImage(UIImage(named: "cancel.png"), forSearchBarIcon: UISearchBarIcon.Clear, state: UIControlState.Normal)
        self.searchBar.setImage(UIImage(named: "glass.png"), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
        
        self.searchBar.delegate = self;
        
        for subView in self.searchBar.subviews
        {
            for subsubView in subView.subviews
            {
                if let textField = subsubView as? UITextField
                {
                    textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search", comment: ""), attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
                }
            }
        }
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("1")
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("2")
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("3")
        searchActive = false
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        picUrl = []
        name = []
        desc = []
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        
        addDummyData( searchBar.text! )
        searchActive = true
        
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("5")
        searchActive = false;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picUrl.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        if Share.sharedInstance.tabButton {
            //cell.button.layer.borderWidth = 5
        
            cell.imageUrl.layer.cornerRadius = cell.imageUrl.frame.size.width / 2
            cell.imageUrl.clipsToBounds = true
        }
        else {
            cell.imageUrl.clipsToBounds = false
        }
        
        if picUrl[indexPath.row] != "" {
            let url = NSURL(string: picUrl[indexPath.row])
            let data = NSData(contentsOfURL: url!)
            cell.imageUrl.image = UIImage(data: data!)
        }
        if name[indexPath.row] != "" {
            cell.nameLabel.text = name[indexPath.row]
        }
        if desc[indexPath.row] != "" {
            cell.descLabel.text = desc[indexPath.row]
        }
        
        return cell
    
    }
    
    @IBAction func VXWL_clk(sender: UIButton) {
        
        searchBar.text = ""
        self.sharedTab.tabButton = false
        self.tabBtn = false
        VXWL.textColor = UIColor(red: 58.0/255.0, green: 108.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        User.textColor = UIColor.blackColor()
        VXWL_pre.hidden = true
        User_pre.hidden = false
        picUrl = []
        name = []
        desc = []
        VXWL.text = "VXWL(0)"
        
        
        //dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        //})
    }
    
    @IBAction func User_clk(sender: UIButton) {
        
        //TableViewCell.sharedInstance.imageUrl.layer.cornerRadius = TableViewCell.sharedInstance.imageUrl.frame.size.width / 2
        //TableViewCell.sharedInstance.imageUrl.clipsToBounds = true
        
        
        
        searchBar.text = ""
        self.sharedTab.tabButton = true
        self.tabBtn = true
        VXWL.textColor = UIColor.blackColor()
        User.textColor = UIColor(red: 58.0/255.0, green: 108.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        VXWL_pre.hidden = false
        User_pre.hidden = true
        picUrl = []
        name = []
        desc = []
        User.text = "User(0)"
        
        //dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        //})
        
    }
    
    // json parse
    func addDummyData(param: String) {
        
        //request with keyword
        APIProxy.sharedInstance.getData(param, onCompletion: { json -> Void in
            
            print(json)
            var searched_data:JSON
            var count:Int = 0
            //start if
            if !self.sharedTab.tabButton {
                searched_data = json["data"]["voxwells"]
                if searched_data == nil {
                    return
                }
                for index in 0..<searched_data.count {
                    if let _picUrl = searched_data[index]["pict150"].string {
                        self.picUrl.append(_picUrl)
                    } else {
                        self.picUrl.append("")
                    }
                    
                    if let _name = searched_data[index]["name"].string {
                        self.name.append(_name)
                    } else {
                        self.name.append("")
                    }
                    
                    if let _desc = searched_data[index]["street"].string {
                        self.desc.append(_desc)
                    } else {
                        self.desc.append("")
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    count = searched_data.count
                    self.VXWL.text = "VXWL(" + String(count) + ")"
                    self.tableView.reloadData()
                })
            }
            else {
                searched_data = json["data"]["users"]
                if searched_data == nil {
                    return
                }
                for index in 0..<searched_data.count {
                    if let _picture_small = searched_data[index]["picture_small"].string {
                        self.picUrl.append(_picture_small)
                    } else {
                        self.picUrl.append("")
                    }
                    
                    if let _first_name = searched_data[index]["first_name"].string , let _last_name = searched_data[index]["last_name"].string {
                        self.name.append(_first_name + " " + _last_name)
                    } else {
                        self.name.append("")
                    }
                    
                    if let _gender = searched_data[index]["gender"].string {
                        self.desc.append(_gender)
                    } else {
                        self.desc.append("")
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    count = searched_data.count
                    self.User.text = "User(" + String(count) + ")"
                })
            }
            //end if
        })
        //end request.
    }
    //end json parse
}

