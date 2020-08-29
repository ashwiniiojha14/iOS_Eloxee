//
//  OrdersController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 03/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class OrdersController: UIViewController {
    
    let transition = SlideInTransition()
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ordersTableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderTableCellIdentifier")
    }
    
    @IBAction func didSelectedOrdersMenuItem(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        viewController.didMenuTapped = { menuType in
            print(menuType)
            
            self.transitionToMainView(menuType)
        }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.transitioningDelegate = self
        present(viewController, animated: true)
    }
    
    
    func transitionToMainView(_ menuType: MenuType) {
        switch menuType {
        case .profile:
            break
            
        case .home:
            self.navigationController?.popViewController(animated: true)
            
        case .orders:
            break
            
        case .cart:
            break
            
        
            
        case .rateapp:
            break
            
        case .legal:
            break
            
        case .signout:
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
}


extension OrdersController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}


extension OrdersController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResponsiveSingleton.shared.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCellIdentifier", for: indexPath) as! OrdersTableViewCell
        cell.addOrderItems(indexItem: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
