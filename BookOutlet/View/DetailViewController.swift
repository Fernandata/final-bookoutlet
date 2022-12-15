//
//  DetailViewController.swift
//  BookOutlet
//
//  Created by Luis Fernando Salas Gave on 14/12/22.
//

import UIKit

class DetailViewController: UIViewController {

    //Outlets
    @IBOutlet weak var bookImg: UIImageView!
    @IBOutlet weak var bookInfo: UILabel!
    @IBOutlet weak var authorInfo: UILabel!
    @IBOutlet weak var descriptionInfo: UITextView!
    @IBOutlet weak var priceInfo: UILabel!
    
    
    var book: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let string = book?.image
        let url = URL(string: string!)
        bookImg.downloaded(from: url!, contentMode: .scaleToFill)
        bookInfo.text = book?.title
        authorInfo.text = book?.author
        descriptionInfo.text = book?.description
        let newPrice: String = String(book!.price)
        priceInfo.text = newPrice
    }
    
}
