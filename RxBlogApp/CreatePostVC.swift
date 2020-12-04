//
//  CreatePostVC.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import UIKit
import RxSwift

class CreatePostVC: UIViewController {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var bodyTxt: UITextField!
    
    let disposeBag = DisposeBag()
    
    lazy var postViewModel: PostViewModel = {
        return PostViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        
        postViewModel.postCreated
            .drive { (created) in
                if created {
                    let alert = self.getAlert(title: "Post Created", message: nil)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true) {
                            self.titleTxt.text = ""
                            self.bodyTxt.text = ""
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func createPostTapped() {
        
        if titleTxt.text != "" && bodyTxt.text != "" {
            
            let newPost = Post(userId: 1, id: 1, title: titleTxt.text!, body: bodyTxt.text!)
            
            postViewModel.createPost(from: newPost)
            
        } else {
            let alert = self.getAlert(title: "Please enter a body and title", message: nil)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}
