//
//  GitHubSearchViewReactor.swift
//  GitHubSearch
//
//  Created by joon-ho kil on 2020/05/17.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import ReactorKit

final class GitHubSearchViewReactor: Reactor {
  enum Action {
    case updateQuery(String?)
  }

  enum Mutation {
    case setRepos([String])
  }

  struct State {
    var repos: [String]
  }

  let initialState = State(repos: [])
    
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .updateQuery(query): // when user updates the search query
      if let query = query {
        let dummyRepos = ["\(query)1", "\(query)2", "\(query)3"] // dummy result
        return Observable.just(Mutation.setRepos(dummyRepos))
      } else {
        return Observable.just(Mutation.setRepos([])) // empty result
      }
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    case let .setRepos(repos):
      return State(repos: repos) // returns a new state
    }
  }
}
