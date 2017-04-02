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
    let qrCode: String
    let key: String
    let owner: String
    let qrImageURL: String
    let ref: FIRDatabaseReference?
    
    init(){
        qrCode = ""
        key = ""
        owner = ""
        qrImageURL = ""
        ref = nil
    }
    
    
    init(qrCode: String, owner: String, qrImageURL: String, key: String = "") {
        self.key = ""
        self.owner = owner
        self.qrCode = qrCode
        self.qrImageURL = qrImageURL
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.qrCode = snapshotValue["qrCode"] as! String
        self.owner = snapshotValue["owner"] as! String
        self.qrImageURL = snapshotValue["qrImageURL"] as! String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "qrCode": qrCode,
            "owner": owner,
            "qrImageURL": qrImageURL
        ]
    }
}
