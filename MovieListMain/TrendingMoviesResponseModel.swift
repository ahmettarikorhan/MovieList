//
//  TrendingMoviesResponseModel.swift
//  MovieListMain
//
//  Created by mac on 27.08.2024.
//

import Foundation

struct TrendingMoviesResponseModel: Codable {
    let page:Int
    let results:[MovieResponse]
}
struct MovieResponse: Codable{
    let id:Int
    let title:String
    let overview:String
    let poster_path:String
    let vote_averege:Double
    let release_date:String
    
}
