//
//  CommentsViewController.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 3/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    
    // MARK: - Injections
    
    internal var viewModel: CommentsViewModel!
    
    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    var postId: Int? {
        didSet {
            print("postId: \(String(describing: postId))")
        }
    }
    
    
    // MARK: - view life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let postId = postId else { return }
        attemptFetchComments(withPostId: postId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CommentsViewModel(dataService: DataService())
        setupActivityIndicatorView()
        setupTableView()
        setupCell()
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
        let nib = UINib(nibName: "CommentCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "comment_cell")
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
                guard let error = error else { return }
                self.showAlertController(with: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Network Call
    
    private func attemptFetchComments(withPostId postId: Int) {
        viewModel?.fetchComments(withPostId: postId) {[weak self] (success, error) in
            if error != nil {
                self?.updateUI(withStatus: success, error: nil)
                return
            }
            self?.updateUI(withStatus: success, error: error)
        }
    }
    
}






