//
//  PostsViewController.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 3/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    
    // MARK: - Injections
    
    internal var viewModel: PostsViewModel!
    
    
    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        attemptFetchPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PostsViewModel(dataService: DataService())
        setupTableView()
        setupCell()
        setupActivityIndicatorView()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            tableView.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true
    }
    
    
    // MARK: - UI Setup
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    private func setupCell() {
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "post_cell")
    }
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    private func setupActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .gray
        activityIndicatorView.center = CGPoint(x: view.frame.width / 2, y: (view.frame.width / 2) + (view.frame.width / 3))
        view.addSubview(activityIndicatorView)
    }
    
    private func updateUI(withStatus success: Bool, error: Error?) {
        DispatchQueue.main.async {
            if success {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            } else {
                self.activityIndicatorView.stopAnimating()
                if let error = error {
                    self.showAlertController(with: "Message", message: error.localizedDescription, completion: nil)
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_comments_view_controller" {
            let commentsVC = segue.destination as! CommentsViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let post = viewModel.posts[indexPath.row]
            commentsVC.postId = post.id
        }
    }
    
    
    // MARK: - Network Call
    
    private func attemptFetchPosts() {
        viewModel.fetchPosts {[weak self] (success, error) in
            if error != nil {
                self?.updateUI(withStatus: false, error: error)
                return
            }
            self?.updateUI(withStatus: success, error: nil)
        }
    }
    
}


extension PostsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}








