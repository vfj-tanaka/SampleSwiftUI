//
//  GithubAPIClient.swift
//  SampleSwiftUI
//
//  Created by mtanaka on 2022/10/24.
//

import Foundation
import Combine

protocol GithubAPIClientProtocol: AnyObject {
    func searchRespositories(searchWord: String) -> AnyPublisher<Model, Error>
}

final class GithubAPIClient: GithubAPIClientProtocol {
    
    static let shared = GithubAPIClient()
    private init() {}
    
    func searchRespositories(searchWord: String) -> AnyPublisher<Model, Error> {
        
        let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&per_page=20")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Model.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
