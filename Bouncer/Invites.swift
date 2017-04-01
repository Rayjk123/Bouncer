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
    let owner: String
    let ref: FIRDatabaseReference?
    
    init(){
        inviteQR = ""
        key = ""
        owner = ""
        ref = nil
    }
    
    
    init(inviteQR: String, owner: String, key: String = "") {
        self.key = ""
        self.owner = owner
        self.inviteQR = inviteQR
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.inviteQR = snapshotValue["inviteQR"] as! String
        self.owner = snapshotValue["owner"] as! String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "inviteQR": inviteQR,
            "owner": owner
            ]
    }
}
