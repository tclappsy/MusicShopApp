//
//  RecordTableViewController.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/4/20.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RecordTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var albumSearchController = UISearchController()
    
    let albumModel = AlbumModel.sharedInstance
    
    var albums:[AlbumData] = []
    var currentAlbum: [AlbumData]!
    
    var selectedAlbum: AlbumData?
    
    var filteredAlbums: [AlbumData] = []
    
    let albumImages = ["Melophobia":"melo.jpg","..I Care Because You Do":"aphex.jpg","Ok Computer":"ok.jpg","In Rainbows":"inrain.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Albums In Stock"
        
        currentAlbum = albums
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.tableView.rowHeight = 100
        
        refreshAlbums()
        
        albumSearchController = ({
            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.obscuresBackgroundDuringPresentation = false
            search.searchBar.placeholder = "Search by album or name"
            self.tableView.tableHeaderView = search.searchBar
            return search
        }) ()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        print(text)
        
        if text.count > 0 {
            filteredAlbums.removeAll()
            filteredAlbums = albums.filter ({
                ($0.name.lowercased().contains(text.lowercased())) ||
                ($0.band.lowercased().contains(text.lowercased())) ||
                ($0.genre.lowercased().contains(text.lowercased()))
            })
        } else {
            filteredAlbums = albums
        }
        
        print(filteredAlbums.count)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(albumSearchController.isActive) {
            print("filtered album count: \(filteredAlbums.count)")
            return filteredAlbums.count
        } else {
            print("instrument count: \(albums.count)")
            return albums.count

        }
    }
    
    override func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCellTableView
        
        var thisAlbum: AlbumData!
        
        if(albumSearchController.isActive) {
            thisAlbum = filteredAlbums[indexPath.row]
        } else {
            thisAlbum = albums[indexPath.row]
        }
        
        if(albumImages[thisAlbum.name] != nil) {
            cell.albumCover.image = UIImage(named: albumImages[thisAlbum.name]!)
        }
        
        cell.albumName.text = thisAlbum.name
        cell.bandName.text = thisAlbum.band
        cell.price.text = "$" + String(thisAlbum.price)
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAlbum = albums[indexPath.row]
        performSegue(withIdentifier: "description", sender: self)
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "description" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! AlbumInfoViewController
                dvc.thisAlbum = selectedAlbum
                
                let thisAlbum = albums[indexPath.row]
                dvc.image = UIImage(named: albumImages[thisAlbum.name]!)
                
            }
        }
    }
    
    func refreshAlbums() {
        albums.removeAll()
        albums = albumModel.albums
        albums.sort{$0.name < $1.name}
        
        self.tableView.reloadData()
    }
    
    
    func findLogo(inName name: String, logos logosDictionary:[String:String]) -> String {
        var match = "other"
        let logos = Array(logosDictionary.keys)
        for logo in logos {
            if name.lowercased().contains(logo.lowercased()) {
                match = logo
                break
            }
        }
        return match
    }
    
  
    @IBAction func logout(_ sender: Any) {
        
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        onlineRef.removeValue { (error, _) in
            if let error = error {
                print("Removing user online failed: \(error)")
                return
            }
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        performSegue(withIdentifier: "cart", sender: self)
    }
    
    
}
