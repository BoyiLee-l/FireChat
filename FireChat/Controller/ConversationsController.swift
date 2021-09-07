//
//  ConversationsController.swift
//  FireChat
//
//  Created by user on 2021/8/30.
//

import UIKit

private let reuseIdentifer = "ConversationCell"

class ConversationsController: UIViewController {
    
    //MARK: - Properties
    private let myTableView = UITableView()
    
    //MARK: - Lifencycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func showProfile() {
        print("111")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavigantionBar()
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
                                                           target: self, action: #selector(showProfile))
    }
    
    func configureTableView() {
        myTableView.backgroundColor = .white
        myTableView.rowHeight = 80
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        myTableView.tableFooterView = UIView()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        view.addSubview(myTableView)
        myTableView.frame = view.frame
    }
    
    func configureNavigantionBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        cell.textLabel?.text = "text"
        return cell
    }
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

