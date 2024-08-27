//
//  MovieCollectionCell.swift
//  MovieListMain
//
//  Created by mac on 20.08.2024.
//

import Foundation
import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet var movieImageView:UIImageView!
    @IBOutlet var movieTitleButton:UIButton!
    
    func setup(movie:Movie){
        movieImageView.image = movie.image
        movieTitleButton.setTitle(movie.title, for: UIControl.State.normal)
    }
}
