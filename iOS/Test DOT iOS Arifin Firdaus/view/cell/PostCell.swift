//
//  PostCell.swift
//  Test DOT iOS Arifin Firdaus
//
//  Created by Arifin Firdaus on 3/16/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var dataSource: Post? {
        didSet {
            updateUI()
        }
    }
    
    
    // MARK: - View life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    // MARK: - UI Setup
    
    private func updateUI() {
        guard let dataSource = dataSource else { return }
        if let userId = dataSource.userId {
            userIdLabel.text = "@user \(userId)"
        }
        idLabel.text = ""
        titleLabel.text = dataSource.title
        bodyLabel.text = dataSource.body
    }
    
}
