//
//  ViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 3/31/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class InvitesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let storage = FIRStorage.storage()
    private lazy var inviteRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "guests")
    private var inviteRefHandle: FIRDatabaseHandle?
    let emptyLabel = UILabel()
    
    let tableview = UITableView()
    
    var invites = [Invites]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Inbox of Invites"
        
        print("There are this many invites " + String(invites.count))
        
        //We're going to update guests and usernames to get the current user's branch of info
        let user = FIRAuth.auth()?.currentUser
        let email = user?.email
        let index = email?.index((email?.endIndex)!, offsetBy: -4)
        let checkEmail = email?.substring(to: index!)
        
        print("This is the checkEmail " + checkEmail!)
        
        inviteRef = inviteRef.child(checkEmail!).child("invites")
        
        /*
        let invite = Invites(inviteQR: "abcde", owner: "Panda")
        let newRef = self.inviteRef.childByAutoId() //Create a child to store all the information
        newRef.setValue(invite.toAnyObject())
 */
        //If the table view will be empty. Set up empty label
        
        setupTableView()
        
        observeNewinvites()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupEmptyLabel(){
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emptyLabel)
        
        emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        emptyLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emptyLabel.text = "Sorry you have no invites ;("
        emptyLabel.textAlignment = .center
        emptyLabel.font = UIFont(name: "Arial", size: 30)
        emptyLabel.textColor = UIColor.lightGray
        
    }
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        tableview.tableFooterView = UIView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableview)
        
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let invite = invites[indexPath.row]
        
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 60, height: 50))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "You have gotten an invite from " + invite.owner + "!"
        cell.addSubview(label)
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = DisplayQRViewController()
        view.inviteInstance = invites[indexPath.row]
        navigationController?.pushViewController(view, animated: true)
    }
    
    
    func observeNewinvites(){
        print("Entered check new Invites")
        inviteRefHandle = inviteRef.observe(.childAdded, with: { (snapshot) in
            //Using an if let just to check that the snapshot value does exist.
            if let invites1 = snapshot.value as? [String: AnyObject]{
                let inviteData = Invites(snapshot: snapshot)
                self.invites.append(inviteData)
                self.tableview.reloadData()
            }
            else{
                self.setupEmptyLabel()
            }
        })
    }
    
    
 
    
    
}

