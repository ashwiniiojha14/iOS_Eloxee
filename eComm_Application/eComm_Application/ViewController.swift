//
//  ViewController.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var register_LoginButton: UIButton!
    
    @IBOutlet weak var socialSignInView: UIView!
    
    @IBOutlet var nameField_HeightConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var errorLabel: UILabel!
    var context: NSManagedObjectContext?
    var userRecord: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        signInButton.layer.cornerRadius = 17
        signUpButton.layer.cornerRadius = 17
        register_LoginButton.layer.cornerRadius = 17
        
        updateButtonUIElement(sender: 201)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func updateButtonUIElement(sender: Int) {
        if sender == 201 {
            signUpButton.backgroundColor = .black
            signUpButton.setTitleColor(.white, for: .normal)
            
            signInButton.backgroundColor = .white
            signInButton.layer.borderWidth = 2
            signInButton.layer.borderColor = UIColor.black.cgColor
            signInButton.setTitleColor(.black, for: .normal)
            
            register_LoginButton.tag = 101
            register_LoginButton.setTitle("Sign Up", for: .normal)
            
            socialSignInView.isHidden = true
            
        } else {
            signInButton.backgroundColor = .black
            signInButton.setTitleColor(.white, for: .normal)
            
            signUpButton.backgroundColor = .white
            signUpButton.layer.borderWidth = 2
            signUpButton.layer.borderColor = UIColor.black.cgColor
            signUpButton.setTitleColor(.black, for: .normal)
            
            register_LoginButton.tag = 102
            register_LoginButton.setTitle("Login", for: .normal)
            
            socialSignInView.isHidden = false
        }
    }
    
    @IBAction func signInSelected() {
        nameField_HeightConstraint.constant = 0
        nameField.isHidden = true
        
        updateButtonUIElement(sender: 202)
    }
    
    @IBAction func signUpSelected() {
        nameField_HeightConstraint.constant = 34
        nameField.isHidden = false
        
        updateButtonUIElement(sender: 201)
    }
    
    @IBAction func login_RegisterSelected(sender: UIButton) {
        if sender.tag == 101 {
            
            // Register Button
            if (nameField.text?.isEmpty)!
            {
              // Display Alert dialog window if the First Name TextField is empty
                errorLabel.text = "Name is required"
            }
            else if (emailField.text?.isEmpty)!
            {
                errorLabel.text = "Email is required"
            }
            
            else if (passwordField.text?.isEmpty)!
            {
               errorLabel.text = "Password is required"
            }
            else {
                errorLabel.text = ""
                let uname = nameField.text!
                let uemailid = emailField.text!
                let upassword = passwordField.text!
                print(uname)
                print(uemailid)
                print(upassword)
                
                }
            
            print("Registration Selected")
            
            addItemsToDatabase(userName: nameField.text!, userEmail: emailField.text!, userPassword: passwordField.text!)
            
        } else {
            // Login Button
            if (emailField.text?.isEmpty)!
            {
                errorLabel.text = "Email is required"
            }
            
            else if (passwordField.text?.isEmpty)!
            {
               errorLabel.text = "Password is required"
            }
            else {
                errorLabel.text = ""
                let uemailid = emailField.text!
                let upassword = passwordField.text!
                print(uemailid)
                print(upassword)
                
                }
            print("Login Selected")
            
            fetchRecords(userEmail: emailField.text!, userPassword: passwordField.text!)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    

}



extension ViewController {
    
    func showAlert(alert_title: String, alert_message: String, isRegistration: Bool) {
        let alert = UIAlertController(title: alert_title, message: alert_message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Thank You..!", style: .default, handler: { action in
            if isRegistration {
                self.nameField_HeightConstraint.constant = 0
                self.nameField.isHidden = true
                self.updateButtonUIElement(sender: 202)
            }
        })
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addItemsToDatabase(userName: String, userEmail: String, userPassword: String) {
        userRecord = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!)
        userRecord?.setValue(userName, forKey: "name")
        userRecord?.setValue(userEmail, forKey: "email")
        userRecord?.setValue(userPassword, forKey: "password")
        
        saveContext()
        
    }
    
    func saveContext () {
        if context!.hasChanges {
            do {
                try context!.save()
                nameField.text = nil
                emailField.text = nil
                passwordField.text = nil
                showAlert(alert_title: "Registration Success", alert_message: "Sign in to continue", isRegistration: true)
            } catch {
                //                let nserror = error as NSError
                //                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                //                abort()
                showAlert(alert_title: "Registration Failed", alert_message: "Please try again", isRegistration: false)
            }
        }
    }
    
    func fetchRecords(userEmail: String, userPassword: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        var objects = [Any]()
        var matches: NSManagedObject?
        
        let predicateValue = NSPredicate(format: "(email = %@)", userEmail)
        request.predicate = predicateValue
        
        do {
            objects = try (context?.fetch(request))!
            if objects.count == 0 {
                showAlert(alert_title: "Failed to Login", alert_message: "Please check you Email", isRegistration: false)
            } else {
                
                matches = (objects[0] as! NSManagedObject)
                
                let name_Field = (matches?.value(forKey: "name") as! String)
                let password_Field = (matches?.value(forKey: "password") as! String)
                
                if password_Field == userPassword {
                    loginSucess()
                } else {
                    showAlert(alert_title: "Failed to Login", alert_message: "Please check your Password", isRegistration: false)
                }
                
                nameField.text = nil
                emailField.text = nil
                passwordField.text = nil
                
                print("Name: \(name_Field) \t Password:\(password_Field)")
                
            }
        } catch {
            print("error")
        }
    }
    
    func loginSucess() {
        if #available(iOS 13.0, *) {
            let menuController = self.storyboard?.instantiateViewController(identifier: "mainVC") as! MainViewController
            self.navigationController?.pushViewController(menuController, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
}

