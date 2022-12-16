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
    @IBOutlet weak var authorImg: UIImageView!
    
    var book: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let string = book?.image
        let url = URL(string: string!)
        bookImg.downloaded(from: url!, contentMode: .scaleToFill)
        
        authorImg.layer.cornerRadius = authorImg.frame.size.width / 2
        authorImg.clipsToBounds = true
        
        let string2 = book?.author_image
        let url2 = URL(string: string2!)
        authorImg.downloaded(from: url2!, contentMode: .scaleToFill)
        
        bookInfo.text = book?.title
        authorInfo.text = book?.author
        descriptionInfo.text = book?.description
        let newPrice: String = String(book!.price)
        priceInfo.text = "$\(newPrice)"
    }
    
}
