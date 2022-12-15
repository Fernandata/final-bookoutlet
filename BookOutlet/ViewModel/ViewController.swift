//
//  ViewController.swift
//  BookOutlet
//
//  Created by Luis Fernando Salas Gave on 14/12/22.
//

import UIKit

class ViewController: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var data = [List]()
    var books = [List]()
    
    //instancia de modelo de la vista
    var viewModel = ViewModelList()
    
    //Search Handler
    @IBAction func searchHandler(_ sender: UITextField) {
        if let searchText = sender.text {
            books = searchText.isEmpty ? data :
            data.filter{$0.author.lowercased().contains(searchText.lowercased()) ||
                $0.title.lowercased().contains(searchText.lowercased())}
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.books = data
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        configureView()
        //self.books = self.data
        activity.isHidden = false
    }
    
    private func configureView() {
        activity.startAnimating()
        viewModel.retrieveDataList(URL: "https://fernando-bookstore.netlify.app/.netlify/functions/api/books") { result in
            self.viewModel.dataArray = result
            self.data = result
            self.books = self.data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activity.startAnimating()
                self.activity.isHidden = true
                print("Success", self.data)
            }
        }
    }
   
}


extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.dataArray.count
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        //let info = viewModel.dataArray[indexPath.row]
        let info = books[indexPath.row]
        cell.titleLabel.text = info.title
        cell.authorLabel.text = info.author
        let string = info.image
        let url = URL(string: string)
        cell.imageAPI.downloaded(from: url!, contentMode: .scaleToFill)
        return cell
    }
    
    //Select Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    
    //Pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.book = books[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    
    
    
}
 



