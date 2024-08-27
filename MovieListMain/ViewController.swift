//
//  ViewController.swift
//  MovieListMain
//
//  Created by mac on 8.08.2024.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var myCollectionView:UICollectionView!
    
    let ACCESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjYwOWQyNzE0ZTQxZGQ4ODczMWU1ZTRkMmRlOWY5NSIsIm5iZiI6MTcyNDc0NDUwOS4wODI5NzQsInN1YiI6IjY2Y2Q3ZmQ3MTNkNjg1ZGM3ZDlhYTcwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2X6i_eFPfdm_J2-52wPBRzXHDzq5-klr8gYeKu6Dz2Q"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
        }
        
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")
        else {
            print("wrong")
            return
        }
        
        var request = URLRequest(url:url)
        request.addValue("application/json", forHTTPHeaderField: "ACCEPT")
        request.addValue("Bearer \(ACCESS_TOKEN)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data,response,error in if let error = error {
            print("ERROR WHİLE FETHİNG DATA: \(error)")
            return
        }
            guard let data = data , let httpResponse = response as?
                    HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("status code is not succesfull: response")
                return
            }
            do{
                let decoder = JSONDecoder()
                let myData = try decoder.decode(TrendingMoviesResponseModel.self, from: data)
                let firstMovie = myData.results[0]
                print("data response movie title: \(firstMovie.title)")
            }catch{
                print("ERROR DECODİNG JSON: \(error)")
            }
            
        }
        task.resume()
      
    }
    
    func getMoviesFromApi() async{
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjYwOWQyNzE0ZTQxZGQ4ODczMWU1ZTRkMmRlOWY5NSIsIm5iZiI6MTcyNDc0NDUwOS4wODI5NzQsInN1YiI6IjY2Y2Q3ZmQ3MTNkNjg1ZGM3ZDlhYTcwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2X6i_eFPfdm_J2-52wPBRzXHDzq5-klr8gYeKu6Dz2Q"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
        } catch {
            print("error")
        }
        
        
    }
    



}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! MovieCollectionCell
        
        cell.setup(movie: movieList[indexPath.row])
        print(String(indexPath.row) + "Movie Title: " + movieList[indexPath.row].title)
        return cell
    }
    
    
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 300.0)
    }
}

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected" + movieList[indexPath.row].title)
        
        var detailViewController = DetailViewController()
        
        if let myNavController = self.navigationController{
            let storyBoard = UIStoryboard(name:"Main", bundle: nil)
            let detailViewController:DetailViewController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as! DetailViewController
            
            detailViewController.selectedIndex = indexPath.row
            myNavController.pushViewController(detailViewController, animated: true)
        }
    }
}


