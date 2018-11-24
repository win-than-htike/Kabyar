//
//  RegisterViewController.swift
//  Kabyar
//
//  Created by Win Than Htike on 11/22/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRetypePassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onClickProfileUpload(_ sender: UIButton) {
        self.chooseUpload(sender, imagePickerControllerDelegate: self)
    }
    
    @IBAction func onClickRegister(_ sender: UIButton) {
        
        if tfPassword.text!.isEmpty {
            showAlertDialog(inputMessage: "Password is Empty!")
            return
        }
        
        if tfRetypePassword.text!.isEmpty {
            showAlertDialog(inputMessage: "Confirm Password is Empty!")
            return
        }
        
        if tfPassword.text! == tfRetypePassword.text! {
         
            let user = UserVO()
            user.username = tfUsername.text!
            user.phone = tfPhone.text!
            user.email = tfEmail.text!
            user.password = tfPassword.text!
            user.confirmPassword = tfRetypePassword.text!
            
            DataModel.shared.register(user: user)
            
        }
        
    }
    
    
    
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            DataModel.shared.uploadImage(data: pickedImage.pngData(), success: { (url) in
                
                self.ivProfile.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "profile-placeholder"))
                
            }) {
                self.showAlertDialog(inputMessage: "Error.")
            }
            
        }
        
    }
    
}
