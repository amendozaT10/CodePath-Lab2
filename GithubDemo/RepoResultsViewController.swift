//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{

    @IBOutlet weak var repoTableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    
    
    override func viewDidAppear(_ animated: Bool) {
        doSearch()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoTableView.dataSource = self
        repoTableView.delegate = self
        repoTableView.estimatedRowHeight = 200
        repoTableView.rowHeight = UITableViewAutomaticDimension

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        

        // Perform the first search when the view controller first loads
        
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            
            self.repos = newRepos
            self.repoTableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
        
        //self.repoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as? RepoCellTableViewCell
        if let repoName = repos[indexPath.row].name  {
            cell?.titleLabel.text = repoName
        }
        
        if let repoProfileURL = repos[indexPath.row].ownerAvatarURL {
            let url = URL(string: repoProfileURL)
            cell?.profileImageView.setImageWith(url!)
        }
        
        if let repoDesc = repos[indexPath.row].repoDescription {
            if(indexPath.row == 2) {
                cell?.mainLabel.text = "// Perform request to GitHub API to get the list of repositories. // Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories. // Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories// Perform request to GitHub API to get the list of repositories"
                
            }else {
            cell?.mainLabel.text = repoDesc
            }
        }
        
        return cell!
    }
    
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
