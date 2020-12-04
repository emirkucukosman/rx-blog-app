//
//  ViewController.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let refresher = UIRefreshControl()
    
    var selectedPost: Post!
    
    lazy var postViewModel: PostViewModel = {
        return PostViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.refreshControl = refresher
        
        refresher.addTarget(postViewModel, action: #selector(postViewModel.getPosts), for: .valueChanged)
        
        setupBindings()
        postViewModel.getPosts()
    }

    func setupBindings() {
                
        postViewModel.posts
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { row, model, cell in
                cell.textLabel?.text = model.title
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe { (event) in
                if let element = event.element {
                    self.selectedPost = self.postViewModel.modelForIndexAt(element.row)
                    self.performSegue(withIdentifier: "toPostDetailsVC", sender: nil)
                }
            }
            .disposed(by: disposeBag)
        
        postViewModel.errorMessage
            .drive { (message) in
                if message != nil {
                    let alert = self.getAlert(title: message!, message: nil)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        postViewModel.postsLoading
            .drive(refresher.rx.isRefreshing)
            .disposed(by: disposeBag)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostDetailsVC" {
            let destination = segue.destination as! PostDetailsVC
            destination.chosenPost = selectedPost
        }
    }

}

