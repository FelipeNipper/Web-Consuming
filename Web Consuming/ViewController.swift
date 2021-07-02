//
//  ViewController.swift
//  Web Consuming
//
//  Created by Felipe Grosze Nipper de Oliveira on 01/07/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var popularMovies:[Movie] = []
    var nowPlayingMovies:[Movie] = []
    
    let api = Api()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        api.getPopular(page: 1){ movies in
            self.popularMovies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        api.getNowPlaying(page: 1){ movies in
            self.nowPlayingMovies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        print(popularMovies)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return popularMovies.count
        } else if section == 1 {
            return nowPlayingMovies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popular Movies"
        } else if section == 1 {
            return "Now Playing"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                var title: String = ""

                if section == 0 {
                    title = "Popular Movies"

                } else if section == 1 {
                    title = "Now Playing"
                }

                let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))

                header.backgroundColor = .white

                let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.size.width, height: 22))

                label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)

                label.text = title

                header.addSubview(label)

                return header
            }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! TableViewCell
            
            let popularMovie = popularMovies[indexPath.row]
            
            cell.titleLabel.text = popularMovie.title
            cell.overviewLabel.text = popularMovie.overview
            cell.ratingsLabel.text = "\(popularMovie.vote_average ?? 0)"
            api.getImage(path: popularMovie.image ?? ""){ imageApi in
                cell.posterImage.image = imageApi
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! TableViewCell
            
            let nowPlaying = nowPlayingMovies[indexPath.row]
            
            cell.titleLabel.text = nowPlaying.title
            cell.overviewLabel.text = nowPlaying.overview
            cell.ratingsLabel.text = "\(nowPlaying.vote_average ?? 0)"
            api.getImage(path: nowPlaying.image ?? ""){ imageApi in
                cell.posterImage.image = imageApi
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            performSegue(withIdentifier: "detailsNavigation", sender: popularMovies[indexPath.row])
        } else if indexPath.section == 1{
            performSegue(withIdentifier: "detailsNavigation", sender: nowPlayingMovies[indexPath.row])
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movie = sender as? Movie else { return }
        
        guard let nextViewController = segue.destination as? DetailsViewController else { return }
        nextViewController.movieId = movie.id
    }
    

}

