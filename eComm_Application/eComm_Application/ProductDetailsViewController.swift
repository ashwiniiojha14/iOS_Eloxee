//
//  ProductDetailsViewController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 03/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class ProductDetailsViewController : UIViewController {
    
    var productsData: Products?
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var addCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRightBarButton()
        
        let imageUrl = URL(string: (self.productsData?.imageURL)!)!
        let imageData = try! Data(contentsOf: imageUrl)
        let thumImage = UIImage(data: imageData)
        productImage.image = thumImage
        
        
        self.nameLabel.text = self.productsData?.name!
        self.typeLabel.text = self.productsData?.type!
        self.priceLabel.text = String(format: "₹ %@", (self.productsData?.price)!)
        
        buyNowButton.layer.cornerRadius = 5
        addCartButton.layer.cornerRadius = 5
    }
    
    func addRightBarButton() {
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightButton.setImage(UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.tintColor = .white
        rightButton.addTarget(self, action: #selector(shareSelected), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = barButton
    }

    @objc func shareSelected() {
        let shareView = UIActivityViewController(activityItems: [productImage.image!], applicationActivities: [])
        self.present(shareView, animated: true, completion: nil)
    }

    func updateProductsData(product_Items: Products) {
        self.productsData = product_Items
    }
    
    
    @IBAction func addtoCartSelected() {
        
        ResponsiveSingleton.shared.cartList.append(CartData(cartItem_Name: (self.productsData?.name)!, cartItem_Price: (self.productsData?.price)!, cartItem_URL: (self.productsData?.imageURL)!, cartItem_Type: (self.productsData?.type)!))
        
        
        let cartController = self.storyboard?.instantiateViewController(identifier: "addToCartVC") as! AddToCartViewController
        self.navigationController?.pushViewController(cartController, animated: true)
    }
    
    @IBAction func buyNowSelected() {
        
    }
}
