//
//  LoginViewController.swift
//  Kabyar
//
//  Created by Win Than Htike on 11/22/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfEmail: ShadowTextField!
    
    @IBOutlet weak var tfPassword: ShadowTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        
        DataModel.shared.login(email: tfEmail.text!, password: tfPassword.text!, success: {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
            self.present(nc, animated: true, completion: nil)
            
        }) {
            self.showAlertDialog(inputMessage: "User does not exist. Please Register.")
        }
        
    }
    
    @IBAction func onClickRegister(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! UINavigationController
        self.present(nc, animated: true, completion: nil)
        
    }
    
}
