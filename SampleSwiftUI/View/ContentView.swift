//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by mtanaka on 2022/10/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    @State private var searchText = ""
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("リポジトリ検索", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button {
                    viewModel.searchButtonTapped(searchWord: searchText)
                } label: {
                    Text("検索")
                        .frame(width: 60, height: 32)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
                .padding(.trailing, 12)
            }
            
            List {
                ForEach(viewModel.repositories) {
                    Text($0.fullName)
                }
            }
            .listStyle(.inset)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let testItems: [Model.Item] = (1...2).map {
        .init(id: $0, fullName: "\($0) FullName")
    }
    
    static var previews: some View {
        ContentView(viewModel: ViewModel(githubAPIClient: GithubAPIClientPreviews()))
    }
}

class GithubAPIClientPreviews: GithubAPIClientProtocol {
    
    let expectedItems: [Model.Item] = (1...10).map {
        .init(id: $0, fullName: "\($0) FullName")
    }
    func searchRespositories(searchWord: String) -> AnyPublisher<Model, Error> {
        Just(Model(totalCount: 10, incompleteResults: false, items: expectedItems))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
