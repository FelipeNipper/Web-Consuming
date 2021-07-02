//
//  ViewController.swift
//  Web Consuming
//
//  Created by Felipe Grosze Nipper de Oliveira on 01/07/21.
//

import UIKit

class ViewController: UIViewController {
    var movies:[Movie] = []
    var movie:Movie = Movie()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = Api()
//        api.getNowPlaying(page: 1) { movie in
//            self.movies = movie
//        }
        api.getDetails(movieId: 550) { movie in
            self.movie = movie
        }
        print("\(movies)")
    }


}

