//
//  DetailViewController.swift
//  MovieListMain
//
//  Created by mac on 21.08.2024.
//

import Foundation
import UIKit

class DetailViewController:UIViewController{
    
    var selectedIndex:Int = 0
    @IBOutlet weak var movieStartButton: UIButton!
    @IBOutlet weak var movieStartButton2: UIButton!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var relaseDate: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var desc: UITextView!
    @IBOutlet var movieImage: UIImageView!

    
    
    
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("Selected Index: \(selectedIndex)")
        var movie:Movie = movieList[selectedIndex]
        
        if let temp = movie.image{
            movieImage.image = temp
        }
        if let temp = movie.title{
            movieName.text = temp
        }
        if let temp = movie.duration{
            duration.text = temp
        }
        if let temp = movie.rating{
            ratingLabel.text = temp
        }
        if let temp = movie.genre{
            genre.text = temp
        }
        if let temp = movie.desc{
            desc.text = String(temp)
        }
        
    }
    @IBAction func movieStartButton(_ sender: Any) {
        loadWebView()
    }
    @IBAction func movieStartButton2(_ sender: Any) {
        loadWebView()
    }
    
    func loadWebView(){
        
        if let myNavController = self.navigationController{
            let storyBoard = UIStoryboard(name:"Main", bundle: nil)
            let webViewController:WebViewController = storyBoard.instantiateViewController(withIdentifier:"WebViewController") as! WebViewController
            
            webViewController.selectedMovieIndex = selectedIndex
            webViewController.modalPresentationStyle = .popover
            self.present(webViewController, animated: true)
        }
    }
}
