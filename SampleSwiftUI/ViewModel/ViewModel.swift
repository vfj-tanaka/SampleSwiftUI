//
//  ViewModel.swift
//  SampleSwiftUI
//
//  Created by mtanaka on 2022/10/24.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    private let githubAPIClient: GithubAPIClientProtocol
    private var cancellabeles = Set<AnyCancellable>()
    
    @Published var repositories = [Model.Item]()
    
    init(githubAPIClient: GithubAPIClientProtocol = GithubAPIClient.shared) {
        self.githubAPIClient = githubAPIClient
    }
    
    func searchButtonTapped(searchWord: String) {
        
        githubAPIClient
            .searchRespositories(searchWord: searchWord)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { model in
                self.repositories = model.items
            }
            .store(in: &cancellabeles)
    }
}
