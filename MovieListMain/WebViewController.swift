//
//  WebViewController.swift
//  MovieListMain
//
//  Created by mac on 22.08.2024.
//

import Foundation
import UIKit
import WebKit

class WebViewController:UIViewController{
    @IBOutlet var webView:WKWebView!
    
    var selectedMovieIndex:Int = 0
    var selectedMovie:Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedMovie = movieList[selectedMovieIndex]
        loadYoutube(videoURL: selectedMovie.trailer)
        print(selectedMovie.trailer)
    }
    
    func loadYoutube(videoURL:String){
        if let youtubeURL =  URL(string: videoURL){            webView.load(URLRequest(url: youtubeURL))
        }
        else {return}
       
    }
}

