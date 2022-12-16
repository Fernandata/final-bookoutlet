//
//  ViewModelList.swift
//  BookOutlet
//
//  Created by Luis Fernando Salas Gave on 14/12/22.
//

import Foundation

class ViewModelList {
    //Mecanismo para enlazar la vista con modelo de la vista
    var refreshData = { () -> () in }
    
    //Datos (Array)
    var dataArray: [List] = [] {
        didSet {
         refreshData()
        }
    }
    
    //Fetch Data from API
    func retrieveDataList(URL url: String, completion: @escaping ([List]) -> Void) {
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            do {
                self.dataArray = try JSONDecoder().decode([List].self, from: data!)
                completion(self.dataArray)
            } catch {
                print("Error")
            }
        }
        dataTask.resume()
    }
}
