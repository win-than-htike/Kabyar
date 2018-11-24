//
//  ViewController.swift
//  Kabyar
//
//  Created by Win Than Htike on 11/21/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var kabyarListTableView: UITableView!
    
    var postList : [PostVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.kabyarListTableView.separatorStyle = .none
        self.kabyarListTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        getPosts()
        
    }
    
    func getPosts() {
        
        DataModel.shared.getPost(success: { (data) in
            
            self.postList.removeAll()
            self.postList.append(contentsOf: data)
            self.kabyarListTableView.reloadData()
            
        }, failure: {
            
        })
        
    }
    
    @IBAction func addNewPost(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "CreateKabyar", bundle: nil)
        let nc = storyboard.instantiateViewController(withIdentifier: "AddPostViewController") as! UINavigationController
        self.present(nc, animated: true, completion: nil)
        
    }
    
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let post = self.postList[indexPath.row]
        
        cell.lblTitle.text = post.title ?? "Unknown Title"
        
        cell.lblCreatedDate.text = post.createdDate ?? "Unknown"
        
        if let user = post.user {
            cell.lblUsername.text = user.username ?? "Unknown"
        } else {
            cell.lblUsername.text = "Unknown"
        }
        
        return cell
    }

}

extension ViewController : UITableViewDelegate {
    
}

