//
//  Share.swift
//  SearchTableView
//
//  Created by HIRANO TOMOKAZU on 3/5/16.
//  Copyright © 2016 Akihiro Ito. All rights reserved.
//

import Foundation

class Share {
    class var sharedInstance: Share {
        struct Static {
            static var instance: Share?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Share()
        }
        
        return Static.instance!
    }
    
    var tabButton:Bool = false
}