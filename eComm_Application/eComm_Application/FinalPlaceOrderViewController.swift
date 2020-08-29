//
//  FinalPlaceOrderViewController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 07/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class FinalPlaceOrderViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var flatTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var cardHolderNameField: UITextField!
    @IBOutlet weak var cardHolderNoField: UITextField!
    @IBOutlet weak var cardHolderMonthYearField: UITextField!
    @IBOutlet weak var cardHolderCVVField: UITextField!
    
    @IBOutlet weak var finalOrderPlacement: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidAppear(true)
        
        finalOrderPlacement.layer.cornerRadius = 7
    }
    
    @IBAction func finalOrderPlaceSelected() {
        let randomNo = randomString(length: 8)
        
        addItemsToOrderList(orderID: randomNo)
        
        if (nameTextField.text?.isEmpty)!
        {
          // Display Alert dialog window if the First Name TextField is empty
            errorLabel.text = "Name is required"
        }
        else if (flatTextField.text?.isEmpty)!
        {
            errorLabel.text = "Flat name is required"
        }
        
        else if (streetTextField.text?.isEmpty)!
        {
           errorLabel.text = "Street is required"
        }
            else if (streetTextField.text?.isEmpty)!
            {
               errorLabel.text = "Street is required"
            }
            else if (cityTextField.text?.isEmpty)!
            {
               errorLabel.text = "City is required"
            }
            else if (phoneTextField.text?.isEmpty)!
            {
               errorLabel.text = "Phone is required"
            }
            
            
            else if (cardHolderNameField.text?.isEmpty)!
                       {
                          errorLabel.text = "Card Holder name is required"
                       }
                       else if (cardHolderNoField.text?.isEmpty)!
                       {
                          errorLabel.text = "Number is required is required"
                       }
                       else if (cardHolderMonthYearField.text?.isEmpty)!
                       {
                          errorLabel.text = "Enter Month and year"
                       }
            else if (cardHolderCVVField.text?.isEmpty)!
            {
               errorLabel.text = "Enter CVV"
            }
        else {
            errorLabel.text = ""
          
            
            }
        
        
        let alert = UIAlertController(title: "Order Placed Successfully", message: "Your Order #\(randomNo) will be dispatched shortly", preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Thank You..!", style: .default, handler: { action in
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: MainViewController.self) {
                    ResponsiveSingleton.shared.cartList.removeAll()
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        })
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func addItemsToOrderList(orderID: String) {
        
        var product_Name: String = ""
        
        if ResponsiveSingleton.shared.cartList.count > 1 {
            product_Name = "\(ResponsiveSingleton.shared.cartList[0].item_Name!) + \(ResponsiveSingleton.shared.cartList.count - 1) more items"
        } else {
            product_Name = "\(ResponsiveSingleton.shared.cartList[0].item_Name!)"
        }
        
        ResponsiveSingleton.shared.orderList.append(OrdersData(orderrItem_Name: product_Name, orderItem_ID: orderID))
    }
}
