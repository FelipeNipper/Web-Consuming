//
//  Movie.swift
//  Web Consuming
//
//  Created by Felipe Grosze Nipper de Oliveira on 01/07/21.
//

import Foundation
import UIKit

struct Movie {
    var title: String?
    var overview:String?
    var genre_ids:[Int]?
    var id:Int?
    var popularity:Double?
    var vote_average:Double?
    var poster_path: String?
    var genres:[Genres]?
    var image:UIImage?
}
