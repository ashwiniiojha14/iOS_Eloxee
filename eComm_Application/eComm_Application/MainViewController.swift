//
//  MainViewController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

protocol productsDetailProtocol: class {
    func movetoDetailController(productDetails: Products)
}

class MainViewController: UIViewController {
    
    fileprivate let kCommerceListTableEstimatedHeight: CGFloat = 270.0
    
    let cartButton = SSBadgeButton()
    
    var commerceTableView: UITableView!
    var contentModel: [Content]?
    
    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        //self.fetchJSONData()
        self.fetchJSONLocally()
    }
    
    func displayAlert_forRating() {
          let alertView = UIAlertController(title: "Thanks for choosing Eloxee. Rate Us", message: "", preferredStyle: .alert)
          alertView.addAction(UIAlertAction(title: "Bad", style: .cancel, handler: { action in
              print("Bad Review")
          }))
          
          alertView.addAction(UIAlertAction(title: "Good", style: .default, handler: { action in
              print("Good Review")
          }))
          
          self.present(alertView, animated: true, completion: nil)
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCartButton()
    }
    
    func setupCartButton() {
        cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        cartButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        cartButton.tintColor = .white
        cartButton.addTarget(self, action: #selector(moveToCartController), for: .touchUpInside)
        cartButton.badge = "\(ResponsiveSingleton.shared.cartList.count)"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
    }
    
    func setupTableView() {
        
        commerceTableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        commerceTableView!.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        commerceTableView!.dataSource = self
        commerceTableView!.delegate = self
        commerceTableView.separatorStyle = .none
        commerceTableView.allowsSelection = false
        self.view.addSubview(commerceTableView!)
    }
    
    
    func registerNib() {
        
        commerceTableView.register(UINib(nibName: "eCommerceHorizontalScrollTableViewCell", bundle: nil), forCellReuseIdentifier: "horizontalScrollViewIdentifier")
        commerceTableView.register(UINib(nibName: "eCommerceSplitTableViewCell", bundle: nil), forCellReuseIdentifier: "splitTableViewCellIdentifier")
        commerceTableView.register(UINib(nibName: "eCommerceBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "bannerTableCellIdentifier")
    }
    
    
    func fetchJSONData() {
        ResponseManager.callItemsList { (success) in
            if success {
                print("Success call back")
                self.contentModel = ResponsiveSingleton.shared.responseContentModel
                
                DispatchQueue.main.async {
                    self.setupTableView()
                    self.registerNib()
                }
            }
        }
    }
    
    
    // To fetch data from local json when URL fails
    
    func fetchJSONLocally() {
        ResponseManager.getProducts { (success) in
            if success {
                print("Success call back")
                self.contentModel = ResponsiveSingleton.shared.responseContentModel
                
                DispatchQueue.main.async {
                    self.setupTableView()
                    self.registerNib()
                }
            }
        }
    }
    
    @IBAction func didSelectedMenuItem(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        viewController.didMenuTapped = { menuType in
            print(menuType)
            
            self.transitionToMainView(menuType)
        }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.transitioningDelegate = self
        present(viewController, animated: true)
    }
    
    
    @objc func moveToCartController() {
        if ResponsiveSingleton.shared.cartList.count == 0 {
            noItemsAlert(title: "Your Cart is Empty", message: "Add items to it now")
        } else {
            let cartController = self.storyboard?.instantiateViewController(identifier: "addToCartVC") as! AddToCartViewController
            self.navigationController?.pushViewController(cartController, animated: true)
        }
    }
    
    @objc func moveToOrderViewController() {
        if ResponsiveSingleton.shared.orderList.count == 0 {
            noItemsAlert(title: "No orders yet", message: "Please Continue your shopping")
        } else {
            let orders_Controller = self.storyboard?.instantiateViewController(identifier: "ordersVC") as! OrdersController
            self.navigationController?.pushViewController(orders_Controller, animated: true)
        }
    }
    
    func transitionToMainView(_ menuType: MenuType) {
        switch menuType {
        case .profile:
            break
            
        case .home:
            break
            
        case .orders:
            moveToOrderViewController()
            
        case .cart:
            moveToCartController()
            
     case .rateapp:
         displayAlert_forRating()
         
     case .legal:
         let next_VC = self.storyboard?.instantiateViewController(identifier: "legal_about") as! LegalandAbout
         self.navigationController?.pushViewController(next_VC, animated: true)
            
        case .signout:
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    func noItemsAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Thank You..!", style: .default, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}


extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCommerceListTableEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCommerceListTableEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentModel!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0...3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalScrollViewIdentifier") as! eCommerceHorizontalScrollTableViewCell
            cell.setupItemsinCells(itemsModel: self.contentModel![indexPath.row])
            cell.delegate = self
            return cell
            
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "bannerTableCellIdentifier") as! eCommerceBannerTableViewCell
            cell.setupBannerImageView(itemModels: self.contentModel![indexPath.row])
            return cell
            
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "splitTableViewCellIdentifier") as! eCommerceSplitTableViewCell
            cell.setupSplitView(itemModels: self.contentModel![indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
}

extension MainViewController: productsDetailProtocol {
    func movetoDetailController(productDetails: Products) {
        let products_Controller = self.storyboard?.instantiateViewController(identifier: "productsVC") as! ProductDetailsViewController
        products_Controller.updateProductsData(product_Items: productDetails)
        self.navigationController?.pushViewController(products_Controller, animated: true)
    }
}
