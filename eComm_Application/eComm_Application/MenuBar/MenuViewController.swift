//
//  MenuViewController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case profile
    case home
    case orders
    case cart
    //case notifications
    case rateapp
    case legal
    case signout
}

class MenuViewController: UITableViewController {

    var didMenuTapped: ((MenuType) -> Void)?
    
    @IBOutlet weak var profile_Image: UIImageView!
    @IBOutlet weak var profile_title_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {
            return
        }
        dismiss(animated: true, completion: { [weak self] in
            self?.didMenuTapped?(menuType)
        })
    }
}
