//
//  AddToCartViewController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 06/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit


class AddToCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var placeOrderView: UIView!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.register(UINib(nibName: "eCommerceAddToCartTableViewCell", bundle: nil), forCellReuseIdentifier: "addToCartCellIdentifer")
        
        placeOrderButton.layer.cornerRadius = 5
        
        totalPriceCalculation()
        
        placeOrderView.layer.borderColor = UIColor.black.cgColor
        placeOrderView.layer.borderWidth = 1
        self.view.bringSubviewToFront(placeOrderView)
    }
    
    
    func totalPriceCalculation() {
        var total_Price: Int = 0
        
        for product_price in ResponsiveSingleton.shared.cartList {
            total_Price += Int(product_price.item_Price!)!
        }
        
        self.priceLable.text = "₹ \(total_Price)"
        
        if total_Price == 0 {
            placeOrderView.isHidden = true
            self.navigationController?.popViewController(animated: true)
        } else {
            placeOrderView.isHidden = false
        }
    }
    
    @IBAction func placeORder() {
        let finalPlaceOrder = self.storyboard?.instantiateViewController(identifier: "finalPlacerOrderVC") as! FinalPlaceOrderViewController
        self.navigationController?.pushViewController(finalPlaceOrder, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResponsiveSingleton.shared.cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addToCartCellIdentifer") as! eCommerceAddToCartTableViewCell
        cell.updateItemsToCell(itemsList: ResponsiveSingleton.shared.cartList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 150
      }
      
      func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
          return 150
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ResponsiveSingleton.shared.cartList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            totalPriceCalculation()
        }
    }
}
