//
//  ViewController.swift
//  jsonTest
//
//  Created by Bayram Yeleç on 25.09.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var viewModel = ViewModel()
    
    var filteredModels: [Model] = []
    var isSearching = false
    
    let searchBar = UISearchBar()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
       
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        viewModel.fetchData {
            self.tableView.reloadData()
        }
        
        searchBar.delegate = self
        searchBar.placeholder = "Ara..."
        navigationItem.titleView = searchBar
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredModels.count : viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = isSearching ? filteredModels[indexPath.row] : viewModel.models[indexPath.row]
        
        let imageView = cell.viewWithTag(1) as? UIImageView
        let titleLbl = cell.viewWithTag(2) as? UILabel
        let descriptionLbl = cell.viewWithTag(3) as? UILabel
        let dereceLbl = cell.viewWithTag(4) as? UILabel
        let priceLbl = cell.viewWithTag(5) as? UILabel
        
        
        
        titleLbl?.text = model.title
        descriptionLbl?.text = model.description
        dereceLbl?.text = "\(model.rating?.rate ?? 0.0) Puan"
        priceLbl?.text = "\(model.price ?? 0.0) TL"
        
        if let imageUrl = model.image , let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageView?.image = image
                    }
                }else {
                    DispatchQueue.main.async {
                        imageView?.image = UIImage(named: "placeholder")
                    }
                }
            }.resume()
        } else {
            imageView?.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = isSearching ? filteredModels[indexPath.row] : viewModel.models[indexPath.row]
        
        let detailViewController = DetailViewController()
        detailViewController.items = selectedModel
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isSearching = false
            filteredModels.removeAll()
        } else {
            isSearching = true
            filteredModels = viewModel.models.filter { model in
                model.title!.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        filteredModels.removeAll()
        tableView.reloadData()
    }
    
    
}

