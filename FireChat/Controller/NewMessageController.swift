//
//  NewMessageController.swift
//  FireChat
//
//  Created by DuncanLi on 2023/9/23.
//

import UIKit


private let reuseIdentifer = "UserCell"

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UITableViewController {
    
    //MARK: - Properties
    private var users = [User]()
    private var filterUsers = [User]()
    
    weak var delegate: NewMessageControllerDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchMode: Bool {
        return searchController.isActive &&
        !searchController.searchBar.text!.isEmpty
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        congigureSearchController()
        fetchUsers()
    }
    
    //MARK: - Selector
    @objc func handleDismissal() {
       dismiss(animated: true, completion: nil)
    }
    
    //MARK: API
    func fetchUsers() {
        showLoader(true)
        
        Service.fetchUsers { users in
            self.showLoader(false)
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        configureNavigantionBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.rowHeight = 80
    }
    
    func  congigureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        definesPresentationContext = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = .clear
            
//            let attributes: [NSAttributedString.Key: Any] = [
//                           .foregroundColor: UIColor.black, // 你想要的颜色
//                           .font: UIFont.systemFont(ofSize: 16) // 你想要的字体
//                       ]
//            textField.attributedPlaceholder = NSAttributedString(string: "Search for a user", attributes: attributes)
        }
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
        cell.user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]

        return cell
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        delegate?.controller(self, wantsToStartChatWith: user)
    }
}

extension NewMessageController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filterUsers = users.filter({ user in
            return user.username.contains(searchText) || user.fullname.contains(searchText)
            
        })
        self.tableView.reloadData()
    }
}
