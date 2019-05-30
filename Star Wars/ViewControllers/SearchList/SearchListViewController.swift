//
//  SearchListViewController.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableViewResults: UITableView!
    var query: String = ""
    let searchBar = UISearchBar()
    var characterResults: [Character] = []
    var nextUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchAndNavigationBar()
        setupHideKeyboardOnTapForSearchList()
        
        getCharactersByQuery()
        self.tableViewResults.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEW_CELL_ID")
        self.tableViewResults.separatorColor = UIColor(
            red: 255, green: 255, blue: 255, alpha: 0.3
        )
    }
    
    func getCharactersByQuery() {
        if let query = searchBar.text {
            API.getCharactersByQuery(
                query: query,
                success:{ (results) in
                    if let finalResults = results.results {
                        self.characterResults = finalResults
                        if results.next != nil {
                            self.nextUrl = results.next!
                        } else {
                            self.nextUrl = ""
                        }
                        self.tableViewResults.reloadData()
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getCharactersByQuery()
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

extension SearchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEW_CELL_ID") as! ResultTableViewCell
        
        let character: Character = characterResults[indexPath.row]
            
        cell.lblName.text = character.name
        cell.backgroundColor = UIColor.clear
        
//        var bulk_no = characterResults.count
        
//        if (indexPath.row >= bulk_no - 3) {
//            if (self.nextUrl != "") {
//                API.getCharactersByUrl(
//                    url: nextUrl,
//                    success: { (results) in
//                        if let count = results.count {
//                            bulk_no += count
//                        }
////                        if let finalResults = results.results {
////                            self.characterResults.append(contentsOf: finalResults)
////                        }
////                        if results.next != nil {
////                            self.nextUrl = results.next!
////                        } else {
////                            self.nextUrl = ""
////                        }
//                        print(indexPath.row)
//                        print(bulk_no)
//                        self.tableViewResults.reloadData()
//                },
//                    failure: {(error) in print(error)})
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
