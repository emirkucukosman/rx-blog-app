//
//  PostViewModel.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import Foundation
import RxSwift
import RxCocoa

class PostViewModel {
    
    private let _posts = BehaviorRelay<[Post]>(value: [])
    private let _postCreated = BehaviorRelay<Bool>(value: false)
    private let _postsLoading = BehaviorRelay<Bool>(value: false)
    private let _errorMessage = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    
    var posts: Driver<[Post]> {
        return _posts.asDriver(onErrorJustReturn: [])
    }
    
    var postsLoading: Driver<Bool> {
        return _postsLoading.asDriver(onErrorJustReturn: false)
    }

    var postCreated: Driver<Bool> {
        return _postCreated.asDriver(onErrorJustReturn: false)
    }
    
    var errorMessage: Driver<String?> {
        return _errorMessage.asDriver(onErrorJustReturn: nil)
    }
    
    @objc func getPosts() {
        
        self._postsLoading.accept(true)
        
        PostService.shared.getPosts()
            .subscribe { (posts) in
                self._errorMessage.accept(nil)
                self._posts.accept(posts)
                self._postsLoading.accept(false)
            } onFailure: { (error) in
                self._errorMessage.accept(error.localizedDescription)
                self._postsLoading.accept(false)
            }
            .disposed(by: disposeBag)

    }
    
    func createPost(from post: Post) {
        
        PostService.shared.createPost(from: post)
            .subscribe {
                self._errorMessage.accept(nil)
                self._postCreated.accept(true)
            } onError: { (error) in
                self._errorMessage.accept(error.localizedDescription)
                self._postCreated.accept(false)
            }
            .disposed(by: disposeBag)
        
    }
    
    func modelForIndexAt(_ index: Int) -> Post {
        return _posts.value[index]
    }
    
}
