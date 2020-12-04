//
//  PostDetailsVC.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import UIKit

class PostDetailsVC: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    var chosenPost: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = "\(chosenPost.id)"
        titleLabel.text = chosenPost.title
        bodyLabel.text = chosenPost.body
    }

}
