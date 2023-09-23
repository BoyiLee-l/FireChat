//
//  NewMessageController.swift
//  FireChat
//
//  Created by DuncanLi on 2023/9/23.
//

import UIKit


private let reuseIdentifer = "UserCell"

class NewMessageController: UITableViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    //MARK: - Selector
    @objc func handleDismissal() {
       dismiss(animated: true, completion: nil)
    }
    
    //MARK: API
    func fetchUsers() {
        Service.fetchUsers()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        configureNavigantionBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.rowHeight = 80
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
        
        return cell
    }
}
