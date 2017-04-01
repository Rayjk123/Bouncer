//
//  ViewController.swift
//  Bouncer
//
//  Created by Branden Lee on 3/31/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Firebase

class InvitesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let storage = FIRStorage.storage()
    private lazy var eventRef: FIRDatabaseReference = FIRDatabase.database().reference(withPath: "Event").child("Foods")
    private var eventRefHandle: FIRDatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        let tableview = UITableView()
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 60, height: 30))
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        label.text = String(indexPath.row)
        cell.addSubview(label)
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}

