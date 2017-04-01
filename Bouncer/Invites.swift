//
//  DrawClass.swift
//  Pods
//
//  Created by Branden Lee on 1/23/17.
//
//

import UIKit
import FirebaseDatabase

struct Invites {
    let inviteQR: String
    let key: String
    let ref: FIRDatabaseReference?
    
    init(){
        inviteQR = ""
        key = ""
        ref = nil
    }
    
    
    init(inviteQR: String, key: String = "") {
        self.key = ""
        self.inviteQR = inviteQR
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.inviteQR = snapshotValue["inviteQR"] as! String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return ["inviteQR": inviteQR]
    }
}
