//
//  PostService.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import Foundation
import Alamofire
import RxSwift

final class PostService {
    
    static let shared = PostService()
    
    private init() {}
    
    func getPosts() -> Single<[Post]> {
        
        Single.create { (single) -> Disposable in
            
            let task = AF.request(
                "https://jsonplaceholder.typicode.com/posts",
                method: .get,
                requestModifier: { $0.timeoutInterval = 5 }
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                
                switch response.result {
                
                case .success(let data):
                    guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {
                        return single(.failure(BaseError("Can not read data")))
                    }
                    single(.success(posts))
                    
                case .failure(let error):
                    return single(.failure(BaseError(error.localizedDescription)))
                }
                
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        }
        
    }
    
    func createPost(from post: Post) -> Completable {
        
        Completable.create { (completable) -> Disposable in

            let task = AF.request(
                "https://jsonplaceholder.typicode.com/posts",
                method: .post,
                parameters: post,
                encoder: URLEncodedFormParameterEncoder(destination: .httpBody),
                requestModifier: { $0.timeoutInterval = 5 }
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                
                switch response.result {
                case .success:
                    return completable(.completed)
                    
                case .failure(let error):
                    return completable(.error(error))
                }
                
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        }
        
    }
    
}
