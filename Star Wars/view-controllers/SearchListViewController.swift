//
//  SearchListViewController.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController, UISearchBarDelegate {
    
    var query: String = ""
    let searchBar = UISearchBar()
    var characterResults: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchAndNavigationBar()
        setupHideKeyboardOnTapForSearchList()
        getCharactersByQuery()
    }
    
    func getCharactersByQuery() {
        if let query = searchBar.text {
            API.getCharactersByQuery(
                query: query,
                success:{ (results) in
                    if let finalResults = results.results {
                        self.characterResults = finalResults
                    }
                },
                failure: { (error) in print(error) }
            )
        }
    }
    
    func configureSearchAndNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor(
            red: 254/255, green: 196/255, blue: 45/255, alpha: 1
        );
        self.navigationController?.navigationBar.topItem?.title = "";
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        searchBar.text = query
        searchBar.placeholder = "Pesquisar..."
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func setupHideKeyboardOnTapForSearchList() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: searchBar, action: #selector(searchBar.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
}
