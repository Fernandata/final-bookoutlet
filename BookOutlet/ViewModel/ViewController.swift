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
    
    //instancia de modelo de la vista
    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        configureView()
        activity.isHidden = false
    }
    
    private func configureView() {
        activity.startAnimating()
        viewModel.retrieveDataList(URL: "https://fernando-bookstore.netlify.app/.netlify/functions/api/books") { result in
            self.viewModel.dataArray = result
            self.data = result
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
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let info = viewModel.dataArray[indexPath.row]
        cell.titleLabel.text = info.title
        cell.authorLabel.text = info.author
        let string = info.image
        let url = URL(string: string)
        cell.imageAPI.downloaded(from: url!, contentMode: .scaleToFill)
        return cell
    }
    
}
 



//Download Image
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
