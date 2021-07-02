//
//  DetailsViewController.swift
//  Web Consuming
//
//  Created by Gabriela Zorzo on 02/07/21.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let api = Api()
    
    var movie: Movie = Movie()
    
    var movieId: Int?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        api.getDetails(movieId: movieId ?? 0){ movie in
            self.movie = movie
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailsTableViewCell
        
        cell.titleLabel.text = movie.title
        cell.ratingsLabel.text = "\(movie.vote_average ?? 0)"
        cell.overviewLabel.text = movie.overview
        api.getImage(path: movie.image ?? ""){ imageApi in
            cell.posterImage.image = imageApi
        }
        
        var genres: String = ""
        for n in 0..<(movie.genres?.count ?? 0){
            if n<movie.genres!.count-1{
                genres += "\(String(describing: movie.genres![n].name)), "
            } else {
                genres += "\(String(describing: movie.genres![n].name)) "
            }
        }
        
        cell.genersLabel.text = genres
        
        return cell
    } 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
