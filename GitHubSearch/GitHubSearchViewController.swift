//
//  ViewController.swift
//  GitHubSearch
//
//  Created by joon-ho kil on 2020/05/17.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class GitHubSearchViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    func bind(reactor: GitHubSearchViewReactor) {
      // Action
      searchBar.rx.text
        .map { Reactor.Action.updateQuery($0) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)

      // State
      reactor.state.map { $0.repos }
        .bind(to: tableView.rx.items(cellIdentifier: "cell")) { indexPath, repo, cell in
          cell.textLabel?.text = repo
        }
        .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = GitHubSearchViewReactor() // this makes `bind()` get called
    }


}

