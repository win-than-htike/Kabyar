//
//  AddPostViewController.swift
//  Kabyar
//
//  Created by Win Than Htike on 11/23/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import SDWebImage

class AddPostViewController: BaseViewController {

    @IBOutlet weak var ivKabyar: UIImageView!
    @IBOutlet weak var tfTitle: BorderTextField!
    @IBOutlet weak var tfDesc: CustomTextView!
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        
        let post = PostVO()
        post.title = tfTitle.text!
        post.desc = tfDesc.text!
        post.user = DataModel.shared.user
    
        DataModel.shared.addPost(post: post, success: {
            self.dismiss(animated: true, completion: nil)
        }) {
            
        }
        
    }
    
    @IBAction func onClickUploadPhoto(_ sender: UIButton) {
        
        self.chooseUpload(sender, imagePickerControllerDelegate: self)
        
    }
    
}

extension AddPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            DataModel.shared.uploadImage(data: pickedImage.pngData(), success: { (url) in
                
                self.ivKabyar.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "kabyar-placeholder"))
                
            }) {
                self.showAlertDialog(inputMessage: "Error.")
            }
            
        }
        
    }
    
}
